class CreateEnrollmentForms < ActiveRecord::Migration
  def change
    create_table :enrollment_forms do |t|
      t.integer :enrollment_id
      t.string :enrollment_uid
      t.boolean :success
      t.string :of_approval_status
      t.string :of_submit_timestamp
      t.string :of_partner_rep_name
      t.string :of_partner_rep_title
      t.string :of_partner_rep_email
      t.string :of_terms_and_conditions
      t.string :of_authorized_to_sign
      t.string :of_decline_offer_reasons
      t.inet :of_partner_ip
      t.text :of_partner_location
      
      t.timestamps null: false
    end
  end
end
