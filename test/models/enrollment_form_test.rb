# == Schema Information
# Schema version: 20160528071752
#
# Table name: enrollment_forms
#
#  id                       :integer          not null, primary key
#  enrollment_id            :integer
#  enrollment_uid           :string
#  success                  :boolean
#  of_approval_status       :string
#  of_submit_timestamp      :string
#  of_partner_rep_name      :string
#  of_partner_rep_title     :string
#  of_partner_rep_email     :string
#  of_terms_and_conditions  :string
#  of_authorized_to_sign    :string
#  of_decline_offer_reasons :string
#  of_partner_ip            :inet
#  of_partner_location      :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'test_helper'

class EnrollmentFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
