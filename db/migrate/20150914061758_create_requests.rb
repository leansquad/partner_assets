class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :quickbase_id

      t.string :background_color, null: false
      t.text :terms, null: false
      t.text :city_or_state, null: false

      t.text :physical_address, null: false
      t.text :company_overview, null: false
      t.text :product_feature, null: false
      t.string :card_type, null: false
      t.string :balance_enquire_method, null: false

      t.timestamps null: false
    end

    add_index :requests, :quickbase_id
  end
end
