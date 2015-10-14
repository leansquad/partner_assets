class RequestsController < ApplicationController

  # GET /requests/1
  def show
    render :already_submitted
  end

  # GET /requests/new
  def new
    if session[:submitted_offer_ids].present? && session[:submitted_offer_ids].is_a?(Array) &&
        session[:submitted_offer_ids].include?(params[:reid])
      render :already_submitted
    else
      session[:submitted_offer_ids] = [] if session[:submitted_offer_ids].blank?
      @request = Request.new(offer_id: params[:reid])
    end
  end

  # POST /requests
  def create
    @request = Request.new(request_params)

    if @request.save
      if session[:submitted_offer_ids].present? && session[:submitted_offer_ids].is_a?(Array)
        session[:submitted_offer_ids] << request_params[:offer_id]
      else
        session[:submitted_offer_ids] = [request_params[:offer_id]]
      end

      render :show
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def request_params
    params.require(:request).permit(
        :background_color, :terms, :city_or_state, :physical_address, :company_overview, :product_feature,
        :card_type, :balance_enquire_method, :product_image, :partner_logo, :gift_card_image, :offer_id,
        :product_image2, :partner_logo2, :gift_card_image2)
  end
end
