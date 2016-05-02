# == Schema Information
# Schema version: 20160502111859
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
#  product_image3_file_name      :string
#  product_image3_content_type   :string
#  product_image3_file_size      :integer
#  product_image3_updated_at     :datetime
#  product_image4_file_name      :string
#  product_image4_content_type   :string
#  product_image4_file_size      :integer
#  product_image4_updated_at     :datetime
#
# Indexes
#
#  index_requests_on_quickbase_id  (quickbase_id)
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
