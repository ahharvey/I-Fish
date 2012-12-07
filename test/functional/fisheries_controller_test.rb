require 'test_helper'

class FisheriesControllerTest < ActionController::TestCase
  setup do
    @fishery = fisheries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fisheries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fishery" do
    assert_difference('Fishery.count') do
      post :create, fishery: { code: @fishery.code, name: @fishery.name }
    end

    assert_redirected_to fishery_path(assigns(:fishery))
  end

  test "should show fishery" do
    get :show, id: @fishery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fishery
    assert_response :success
  end

  test "should update fishery" do
    put :update, id: @fishery, fishery: { code: @fishery.code, name: @fishery.name }
    assert_redirected_to fishery_path(assigns(:fishery))
  end

  test "should destroy fishery" do
    assert_difference('Fishery.count', -1) do
      delete :destroy, id: @fishery
    end

    assert_redirected_to fisheries_path
  end
end
