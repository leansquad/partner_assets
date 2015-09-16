require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request" do
    assert_difference('Request.count') do
      post :create, request: { background_color: @request.background_color, balance_enquire_method: @request.balance_enquire_method, card_type: @request.card_type, city_or_state: @request.city_or_state, company_overview: @request.company_overview, physical_address: @request.physical_address, product_feature: @request.product_feature, terms: @request.terms }
    end

    assert_redirected_to request_path(assigns(:request))
  end

  test "should show request" do
    get :show, id: @request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request
    assert_response :success
  end

  test "should update request" do
    patch :update, id: @request, request: { background_color: @request.background_color, balance_enquire_method: @request.balance_enquire_method, card_type: @request.card_type, city_or_state: @request.city_or_state, company_overview: @request.company_overview, physical_address: @request.physical_address, product_feature: @request.product_feature, terms: @request.terms }
    assert_redirected_to request_path(assigns(:request))
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete :destroy, id: @request
    end

    assert_redirected_to requests_path
  end
end
