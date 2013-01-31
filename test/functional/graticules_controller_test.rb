require 'test_helper'

class GraticulesControllerTest < ActionController::TestCase
  setup do
    @graticule = graticules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:graticules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create graticule" do
    assert_difference('Graticule.count') do
      post :create, graticule: { code: @graticule.code }
    end

    assert_redirected_to graticule_path(assigns(:graticule))
  end

  test "should show graticule" do
    get :show, id: @graticule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @graticule
    assert_response :success
  end

  test "should update graticule" do
    put :update, id: @graticule, graticule: { code: @graticule.code }
    assert_redirected_to graticule_path(assigns(:graticule))
  end

  test "should destroy graticule" do
    assert_difference('Graticule.count', -1) do
      delete :destroy, id: @graticule
    end

    assert_redirected_to graticules_path
  end
end
