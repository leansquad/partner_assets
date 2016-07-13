# == Schema Information
# Schema version: 20160528071752
#
# Table name: enrollment_forms
#
#  id                       :integer          not null, primary key
#  enrollment_id            :integer
#  enrollment_uid           :string
#  success                  :boolean
#  of_approval_status       :string
#  of_submit_timestamp      :string
#  of_partner_rep_name      :string
#  of_partner_rep_title     :string
#  of_partner_rep_email     :string
#  of_terms_and_conditions  :string
#  of_authorized_to_sign    :string
#  of_decline_offer_reasons :string
#  of_partner_ip            :inet
#  of_partner_location      :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class EnrollmentForm < ActiveRecord::Base
  include Quickbase

  validates_presence_of :of_approval_status, :of_submit_timestamp, :of_partner_ip, :of_partner_location, :of_partner_rep_name,
      :of_partner_rep_name, :of_partner_rep_title, :of_partner_rep_email, :of_terms_and_conditions, :of_authorized_to_sign,
      :enrollment_uid
      
  before_validation :set_fields, on: :create

  attr_accessor :request_info, :decline_reason1, :decline_reason2, :decline_reason3

  def push
    fields = Settings.quickbase.referrences['enrollments']['fields']

    if success?
      keys = attributes.keys - ['id', 'created_at', 'updated_at', 'of_decline_offer_reasons', 'enrollment_id', 'success', 'enrollment_uid']
    else
      keys = attributes.keys - ['id', 'created_at', 'updated_at', 'enrollment_id', 'success', 'enrollment_uid']
    end

    params = Hash[
      attributes.slice(*keys).collect do |key, value|
        [fields[key].to_s, value.to_s]
      end
    ]
    
    Rails.logger.debug('--------------------------------------')
    Rails.logger.debug('----------UPDATE_REQUEST--------------')
    Rails.logger.debug(params)
    Rails.logger.debug('--------------------------------------')
    
    quickbase.api.edit_record(enrollment_id, params)
  end

  private
  
  def set_fields
    self.of_partner_location = get_partner_location
    self.of_partner_ip = get_remote_ip
    
    unless success?
      self.of_approval_status = 'Declined'
      self.of_decline_offer_reasons = [:decline_reason1, :decline_reason2, :decline_reason3].collect { |r| self.send(r)}.compact.first
    else
      self.of_approval_status = 'Approved'
    end
    
    self.of_terms_and_conditions = of_terms_and_conditions.eql?('Accepted') ? 'Accepted' : 'Declined'
    self.of_authorized_to_sign = of_authorized_to_sign.eql?('YES') ? 'YES' : 'NA'
    
    self.of_submit_timestamp = Time.now.to_s
  end
  
  def get_partner_location
    return '' unless request_info.present? || request_info[0].data.present?
    
    ['city', 'region_name', 'zip_code', 'country_name'].
        collect { |obj| request_info[0].data[obj] }.compact.reject(&:empty?).join(',')
  end
  
  def get_remote_ip
    return '' unless request_info.present? || request_info[0].data.present?

    request_info[0].data['ip']
  end

  def quickbase
    @quickbase ||= Quickbase::Connection.new(
        apptoken: Settings.quickbase.apptoken,
        dbid: Settings.quickbase.referrences['enrollments']['db']
    )
  end
end
