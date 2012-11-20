require 'test_helper'

class DesasControllerTest < ActionController::TestCase
  setup do
    @desa = desas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:desas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create desa" do
    assert_difference('Desa.count') do
      post :create, desa: { name: @desa.name }
    end

    assert_redirected_to desa_path(assigns(:desa))
  end

  test "should show desa" do
    get :show, id: @desa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @desa
    assert_response :success
  end

  test "should update desa" do
    put :update, id: @desa, desa: { name: @desa.name }
    assert_redirected_to desa_path(assigns(:desa))
  end

  test "should destroy desa" do
    assert_difference('Desa.count', -1) do
      delete :destroy, id: @desa
    end

    assert_redirected_to desas_path
  end
end
