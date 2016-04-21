class EnrollmentsController < ApplicationController
  before_filter :set_enrollment, only: :show

  # GET /enrollments/1
  def show
    render :new
  end

  # POST /enrollments
  def create
    form_params = enrollment_params.merge(request_info: Geocoder.search(request.remote_ip))
    @enrollment = EnrollmentForm.new(form_params)
    @enrollment.push

    render 'thank_you'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def enrollment_params
    params.
        require(:enrollment).
        permit(:id, :success, :of_terms_and_conditions, :of_authorized_to_sign,
               :of_partner_rep_name, :of_partner_rep_title, :of_partner_rep_email,
               :decline, :decline_reason1, :decline_reason2, :decline_reason3
        )
  end

  def set_enrollment
    @enrollment = Enrollment.new(params)
  end
end
