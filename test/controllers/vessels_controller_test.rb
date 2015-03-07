require 'test_helper'

class VesselsControllerTest < ActionController::TestCase
  setup do
    @vessel = vessels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vessels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vessel" do
    assert_difference('Vessel.count') do
      post :create, vessel: { code_of_conduct: @vessel.code_of_conduct, company_id: @vessel.company_id, flag_state: @vessel.flag_state, gear_id: @vessel.gear_id, imo_number: @vessel.imo_number, iuu_list: @vessel.iuu_list, length: @vessel.length, name: @vessel.name, shark_policy: @vessel.shark_policy, tonnage: @vessel.tonnage, vessel_type_id: @vessel.vessel_type_id, year_built: @vessel.year_built }
    end

    assert_redirected_to vessel_path(assigns(:vessel))
  end

  test "should show vessel" do
    get :show, id: @vessel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vessel
    assert_response :success
  end

  test "should update vessel" do
    patch :update, id: @vessel, vessel: { code_of_conduct: @vessel.code_of_conduct, company_id: @vessel.company_id, flag_state: @vessel.flag_state, gear_id: @vessel.gear_id, imo_number: @vessel.imo_number, iuu_list: @vessel.iuu_list, length: @vessel.length, name: @vessel.name, shark_policy: @vessel.shark_policy, tonnage: @vessel.tonnage, vessel_type_id: @vessel.vessel_type_id, year_built: @vessel.year_built }
    assert_redirected_to vessel_path(assigns(:vessel))
  end

  test "should destroy vessel" do
    assert_difference('Vessel.count', -1) do
      delete :destroy, id: @vessel
    end

    assert_redirected_to vessels_path
  end
end
