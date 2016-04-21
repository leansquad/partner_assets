class EnrollmentForm
  include Quickbase

  ADDRESS_LINE = ['city', 'region_name', 'zip_code', 'country_name']
  DECLINE_REASONS = [:decline_reason1, :decline_reason2, :decline_reason3]

  def initialize(args)
    request_info = args[:request_info][0].data
    of_partner_location = ADDRESS_LINE.collect { |obj| request_info[obj] }.compact.reject(&:empty?).join(',')

    @fields = Settings.quickbase.referrences['enrollments']['fields']

    @id = args['id']
    @args =
        if args[:success].to_s == 'true'
          {
              @fields['of_terms_and_conditions'].to_s => 'Accepted',
              @fields['of_authorized_to_sign'].to_s => 'YES',
              @fields['of_approval_status'].to_s => 'Approved',
              @fields['of_submit_timestamp'].to_s => Time.now.to_s,
              @fields['of_partner_ip'].to_s => request_info['ip'],
              @fields['of_partner_location'].to_s => of_partner_location,
              @fields['of_partner_rep_email'].to_s => args['of_partner_rep_email'],
              @fields['of_partner_rep_name'].to_s => args['of_partner_rep_name'],
              @fields['of_partner_rep_title'].to_s => args['of_partner_rep_title'],
          }
        else
          decline_reason = DECLINE_REASONS.collect { |r| args[r]}.compact.first
          {
              @fields['of_terms_and_conditions'].to_s => 'Declined',
              @fields['of_authorized_to_sign'].to_s => 'NA',
              @fields['of_approval_status'].to_s => 'Declined',
              @fields['of_submit_timestamp'].to_s => Time.now.to_s,
              @fields['of_partner_ip'].to_s => request_info['ip'],
              @fields['of_partner_location'].to_s => of_partner_location,
              @fields['of_decline_offer_reasons'].to_s => decline_reason,
          }

        end
  end

  def push
    quickbase.api.edit_record(@id, args)
  end

  def quickbase
    @quickbase ||= Quickbase::Connection.new(
        apptoken: Settings.quickbase.apptoken,
        dbid: Settings.quickbase.referrences['enrollments']['db']
    )
  end

  # attr_reader :of_terms_and_conditions, :of_authorized_to_sign, :of_partner_rep_name, :of_partner_rep_title,
  #             :of_partner_rep_email, :of_decline_offer_reason, :of_approval_status, :of_submit_timestamp,
  #             :of_partner_ip, :of_partner_location

  attr_reader :args
  # private
  #
  # def prepare_filter(id, reference, column = 'id')
  #   "{'#{Settings.quickbase.referrences[reference]['fields'][column]}'.EX.'#{id}'}"
  # end
end