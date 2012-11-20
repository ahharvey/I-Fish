require 'test_helper'

class LandingsControllerTest < ActionController::TestCase
  setup do
    @landing = landings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:landings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create landing" do
    assert_difference('Landing.count') do
      post :create, landing: { boat_size: @landing.boat_size, crew: @landing.crew, engine: @landing.engine, fuel: @landing.fuel, gear_id: @landing.gear_id, grid_square: @landing.grid_square, quantity: @landing.quantity, sail: @landing.sail, time_in: @landing.time_in, time_out: @landing.time_out, value: @landing.value, vessel_name: @landing.vessel_name, vessel_ref: @landing.vessel_ref, weight: @landing.weight }
    end

    assert_redirected_to landing_path(assigns(:landing))
  end

  test "should show landing" do
    get :show, id: @landing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @landing
    assert_response :success
  end

  test "should update landing" do
    put :update, id: @landing, landing: { boat_size: @landing.boat_size, crew: @landing.crew, engine: @landing.engine, fuel: @landing.fuel, gear_id: @landing.gear_id, grid_square: @landing.grid_square, quantity: @landing.quantity, sail: @landing.sail, time_in: @landing.time_in, time_out: @landing.time_out, value: @landing.value, vessel_name: @landing.vessel_name, vessel_ref: @landing.vessel_ref, weight: @landing.weight }
    assert_redirected_to landing_path(assigns(:landing))
  end

  test "should destroy landing" do
    assert_difference('Landing.count', -1) do
      delete :destroy, id: @landing
    end

    assert_redirected_to landings_path
  end
end
