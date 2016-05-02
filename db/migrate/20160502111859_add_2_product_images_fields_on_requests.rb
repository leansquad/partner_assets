class Add2ProductImagesFieldsOnRequests < ActiveRecord::Migration
  def change
    add_attachment :requests, :product_image3
    add_attachment :requests, :product_image4
  end
end
