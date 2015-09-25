class RenameOidFieldInOffers < ActiveRecord::Migration
  def change
    rename_column :requests, :oid, :offer_id
  end
end
