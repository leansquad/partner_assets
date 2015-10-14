# == Schema Information
# Schema version: 20151014051208
#
# Table name: requests
#
#  id                            :integer          not null, primary key
#  offer_id                      :integer
#  quickbase_id                  :integer
#  background_color              :string           not null
#  terms                         :text             not null
#  city_or_state                 :text             not null
#  physical_address              :text             not null
#  company_overview              :text             not null
#  product_feature               :text             not null
#  card_type                     :string
#  balance_enquire_method        :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  product_image_file_name       :string
#  product_image_content_type    :string
#  product_image_file_size       :integer
#  product_image_updated_at      :datetime
#  partner_logo_file_name        :string
#  partner_logo_content_type     :string
#  partner_logo_file_size        :integer
#  partner_logo_updated_at       :datetime
#  gift_card_image_file_name     :string
#  gift_card_image_content_type  :string
#  gift_card_image_file_size     :integer
#  gift_card_image_updated_at    :datetime
#  product_image2_file_name      :string
#  product_image2_content_type   :string
#  product_image2_file_size      :integer
#  product_image2_updated_at     :datetime
#  partner_logo2_file_name       :string
#  partner_logo2_content_type    :string
#  partner_logo2_file_size       :integer
#  partner_logo2_updated_at      :datetime
#  gift_card_image2_file_name    :string
#  gift_card_image2_content_type :string
#  gift_card_image2_file_size    :integer
#  gift_card_image2_updated_at   :datetime
#
# Indexes
#
#  index_requests_on_quickbase_id  (quickbase_id)
#

class Request < ActiveRecord::Base

  validates_presence_of :background_color, :terms, :city_or_state, :physical_address, :company_overview,
                        :product_feature, :balance_enquire_method, :card_type

  validates_inclusion_of :card_type, in: ['Plastic Card', 'Certificate', 'Ticket/Voucher']

  after_create :add_quickbase_record

  has_attached_file :product_image
  has_attached_file :product_image2
  has_attached_file :partner_logo
  has_attached_file :partner_logo2
  has_attached_file :gift_card_image
  has_attached_file :gift_card_image2

  # validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :partner_logo, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :gift_card_image, content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :product_image
  do_not_validate_attachment_file_type :product_image2
  do_not_validate_attachment_file_type :partner_logo
  do_not_validate_attachment_file_type :partner_logo2
  do_not_validate_attachment_file_type :gift_card_image
  do_not_validate_attachment_file_type :gift_card_image2

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
        fields['product_feature'].to_s => product_feature,
        fields['card_type'].to_s => card_type,
        fields['balance_enquire_method'].to_s => balance_enquire_method,
        fields['offer_id'].to_s => offer_id,
        # fields['product_image'].to_s => File.open(product_image.path).read,
    }

    # begin
    quickbase_asset_id = quickbase.api.add_record_returning_rid(args)

    return unless quickbase_asset_id.present?

    update_attribute(:quickbase_id, quickbase_asset_id)

    [:product_image, :partner_logo, :gift_card_image, :product_image2, :partner_logo2, :gift_card_image2].each do |image|
      next unless self.send(image).present?

      quickbase.api.upload_file(
          quickbase_asset_id, fields[image.to_s].to_s,
          File.open(self.send(image).path, 'rb').read, self.send("#{image}_file_name")
      )
    end
    # rescue RuntimeError

    # end
  end
end
