require 'test_helper'

class RespondersControllerTest < ActionController::TestCase
  setup do
    @responder = responders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:responders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create responder" do
    assert_difference('Responder.count') do
      post :create, responder: { length: @responder.length, name: @responder.name }
    end

    assert_redirected_to responder_path(assigns(:responder))
  end

  test "should show responder" do
    get :show, id: @responder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @responder
    assert_response :success
  end

  test "should update responder" do
    patch :update, id: @responder, responder: { length: @responder.length, name: @responder.name }
    assert_redirected_to responder_path(assigns(:responder))
  end

  test "should destroy responder" do
    assert_difference('Responder.count', -1) do
      delete :destroy, id: @responder
    end

    assert_redirected_to responders_path
  end
end
