class EnrollmentsController < ApplicationController
  before_filter :set_enrollment, only: [:show, :print]

  def show
    render :new
  end

  def create
    enrollment_form = EnrollmentForm.new(enrollment_form_params.merge(request_info: Geocoder.search(request.remote_ip)))
    if enrollment_form.save
      enrollment_form.push
      render 'thank_you'
    else
      @enrollment = Enrollment.new(id: enrollment_form_params[:enrollment_id])
      render :new
    end
  end

  def print
    @enrollment_form = EnrollmentForm.find_by(enrollment_uid: params[:id])

    unless @enrollment_form
      render :new
    else
      render :print
    end
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
