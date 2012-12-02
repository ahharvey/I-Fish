require 'test_helper'

class GearsControllerTest < ActionController::TestCase
  setup do
    @gear = gears(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gears)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gear" do
    assert_difference('Gear.count') do
      post :create, gear: { alpha_code: @gear.alpha_code, cat_eng: @gear.cat_eng, cat_ind: @gear.cat_ind, fao_code: @gear.fao_code, name: @gear.name, num_code: @gear.num_code, sub_cat_eng: @gear.sub_cat_eng, sub_cat_ind: @gear.sub_cat_ind, type_eng: @gear.type_eng, type_ind: @gear.type_ind }
    end

    assert_redirected_to gear_path(assigns(:gear))
  end

  test "should show gear" do
    get :show, id: @gear
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gear
    assert_response :success
  end

  test "should update gear" do
    put :update, id: @gear, gear: { alpha_code: @gear.alpha_code, cat_eng: @gear.cat_eng, cat_ind: @gear.cat_ind, fao_code: @gear.fao_code, name: @gear.name, num_code: @gear.num_code, sub_cat_eng: @gear.sub_cat_eng, sub_cat_ind: @gear.sub_cat_ind, type_eng: @gear.type_eng, type_ind: @gear.type_ind }
    assert_redirected_to gear_path(assigns(:gear))
  end

  test "should destroy gear" do
    assert_difference('Gear.count', -1) do
      delete :destroy, id: @gear
    end

    assert_redirected_to gears_path
  end
end
