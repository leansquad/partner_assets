class AddGiftCardImageColumnsToRequests < ActiveRecord::Migration
  def change
    add_attachment :requests, :gift_card_image
  end
end
