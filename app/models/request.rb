# == Schema Information
# Schema version: 20150914062551
#
# Table name: requests
#
#  id                           :integer          not null, primary key
#  quickbase_id                 :integer
#  background_color             :string           not null
#  terms                        :text             not null
#  city_or_state                :text             not null
#  physical_address             :text             not null
#  company_overview             :text             not null
#  product_feature              :text             not null
#  card_type                    :string           not null
#  balance_enquire_method       :string           not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  product_image_file_name      :string
#  product_image_content_type   :string
#  product_image_file_size      :integer
#  product_image_updated_at     :datetime
#  partner_logo_file_name       :string
#  partner_logo_content_type    :string
#  partner_logo_file_size       :integer
#  partner_logo_updated_at      :datetime
#  gift_card_image_file_name    :string
#  gift_card_image_content_type :string
#  gift_card_image_file_size    :integer
#  gift_card_image_updated_at   :datetime
#
# Indexes
#
#  index_requests_on_quickbase_id  (quickbase_id)
#

class Request < ActiveRecord::Base

  validates_presence_of :background_color, :terms, :city_or_state, :physical_address, :company_overview,
                        :product_feature, :card_type, :balance_enquire_method

  validates_inclusion_of :card_type, in: ['Plastic Card', 'Certificate', 'Ticket/Voucher']

  after_create :add_quickbase_record

  has_attached_file :product_image
  has_attached_file :partner_logo
  has_attached_file :gift_card_image

  # validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :partner_logo, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :gift_card_image, content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :product_image
  do_not_validate_attachment_file_type :partner_logo
  do_not_validate_attachment_file_type :gift_card_image

  private

  def add_quickbase_record
    fields = Settings.quickbase.referrences['offer_assets']['fields']

    quickbase = Quickbase::Connection.new(
        apptoken: Settings.quickbase.apptoken,
        dbid: Settings.quickbase.referrences['offer_assets']['db']
    )

    args = {
        fields['background_color'].to_s => background_color,
        fields['terms'].to_s => terms,
        fields['city_or_state'].to_s => city_or_state,
        fields['physical_address'].to_s => physical_address,
        fields['company_overview'].to_s => company_overview,
        fields['product_feature'].to_s => city_or_state,
        fields['card_type'].to_s => card_type,
        fields['balance_enquire_method'].to_s => company_overview,
        # fields['product_image'].to_s => File.open(product_image.path).read,
    }

    # begin
    quickbase.api.add_record(args)
    # quickbase.api.upload_file(21, fields['product_image'].to_s, File.open(a.product_image.path, 'rb').read, a.product_image_file_name )
    # rescue RuntimeError

    # end
  end
end
