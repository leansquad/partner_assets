class AddOfDeclinedOfferReasonOtherToEnrollmentForms < ActiveRecord::Migration
  def change
    add_column :enrollment_forms, :of_declined_offer_reason_other, :text
  end
end
