class EnrollmentsController < ApplicationController
  before_filter :set_enrollment, only: [:show, :print]

  # GET /enrollments/1
  def show
    render :new
  end

  # POST /enrollments
  def create
    enrollment_form = EnrollmentForm.
        new(enrollment_form_params.merge(request_info: Geocoder.search(request.remote_ip)))
    if enrollment_form.save
      enrollment_form.push
      render 'thank_you'
    else
      @enrollment = Enrollment.new(id: enrollment_form_params[:entollment_id])
      render :new
    end
  end
  
  def print
    @enrollment_form = EnrollmentForm.find_by(enrollment_uid: params[:id])
  end

  private

  def enrollment_form_params
    params.
        require(:enrollment_form).
        permit(:enrollment_id, :enrollment_uid, :success, :of_terms_and_conditions, :of_authorized_to_sign,
               :of_partner_rep_name, :of_partner_rep_title, :of_partner_rep_email,
               :decline_reason1, :decline_reason2, :decline_reason3
        )
  end

  def set_enrollment
    @enrollment = Enrollment.new(params)
  end
end
