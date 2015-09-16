class RequestsController < ApplicationController

  # GET /requests/1
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # POST /requests
  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to @request, notice: 'Request was successfully created.'
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def request_params
    params.require(:request).permit(
        :background_color, :terms, :city_or_state, :physical_address, :company_overview, :product_feature,
        :card_type, :balance_enquire_method, :product_image, :partner_logo, :gift_card_image)
  end
end
