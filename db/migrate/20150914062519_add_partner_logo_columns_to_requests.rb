class AddPartnerLogoColumnsToRequests < ActiveRecord::Migration
  def change
    add_attachment :requests, :partner_logo
  end
end
