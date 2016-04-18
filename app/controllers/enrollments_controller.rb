class EnrollmentsController < ApplicationController
  before_filter :set_enrollment

  # GET /enrollments/1
  def show
    render :new
  end

  # GET /enrollments/new
  def new
    existed_enrollment = Request.find_by(offer_id: params[:reid])

    if existed_enrollment
      render :already_submitted
    else
      @enrollment = Request.new(offer_id: params[:reid])
    end
  end

  # POST /enrollments
  def create
    @enrollment = Request.new(enrollment_params)

    if @enrollment.save
      render :show
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  # def enrollment_params
  #   params.require(:enrollment).permit(:id)
  # end

  def set_enrollment
    @enrollment = Enrollment.new(params)
  end
end
