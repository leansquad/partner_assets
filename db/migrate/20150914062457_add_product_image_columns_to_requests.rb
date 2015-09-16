class AddProductImageColumnsToRequests < ActiveRecord::Migration
  def change
    add_attachment :requests, :product_image
  end
end
