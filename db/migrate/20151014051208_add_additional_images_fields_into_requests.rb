class AddAdditionalImagesFieldsIntoRequests < ActiveRecord::Migration
  def change
    add_attachment :requests, :product_image2
    add_attachment :requests, :partner_logo2
    add_attachment :requests, :gift_card_image2
  end
end
