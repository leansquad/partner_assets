class RequestsController < ApplicationController

  # GET /requests/1
  def show
    render :already_submitted
  end

  # GET /requests/new
  def new
    existed_request = Request.find_by(offer_id: params[:reid])

    if existed_request
      render :already_submitted
    else
      @request = Request.new(offer_id: params[:reid])
    end
  end

  # POST /requests
  def create
    @request = Request.new(request_params)

    if @request.save
      render :show
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def request_params
    params.require(:request).
        permit(
            :background_color, :terms, :city_or_state, :physical_address, :company_overview, :product_feature,
            :card_type, :balance_enquire_method, :offer_id,
            *Request::IMAGE_NAMES
        )
  end
end
