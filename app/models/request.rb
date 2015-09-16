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

  has_attached_file :product_image
  has_attached_file :partner_logo
  has_attached_file :gift_card_image

  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :partner_logo, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :gift_card_image, content_type: /\Aimage\/.*\Z/
end
