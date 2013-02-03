require 'test_helper'

class LoggedDaysControllerTest < ActionController::TestCase
  setup do
    @logged_day = logged_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logged_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logged_day" do
    assert_difference('LoggedDay.count') do
      post :create, logged_day: { condition: @logged_day.condition, end_time: @logged_day.end_time, fuel: @logged_day.fuel, gear_time: @logged_day.gear_time, line: @logged_day.line, moon: @logged_day.moon, net: @logged_day.net, quantity: @logged_day.quantity, sail: @logged_day.sail, start_time: @logged_day.start_time, value: @logged_day.value, weight: @logged_day.weight }
    end

    assert_redirected_to logged_day_path(assigns(:logged_day))
  end

  test "should show logged_day" do
    get :show, id: @logged_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logged_day
    assert_response :success
  end

  test "should update logged_day" do
    put :update, id: @logged_day, logged_day: { condition: @logged_day.condition, end_time: @logged_day.end_time, fuel: @logged_day.fuel, gear_time: @logged_day.gear_time, line: @logged_day.line, moon: @logged_day.moon, net: @logged_day.net, quantity: @logged_day.quantity, sail: @logged_day.sail, start_time: @logged_day.start_time, value: @logged_day.value, weight: @logged_day.weight }
    assert_redirected_to logged_day_path(assigns(:logged_day))
  end

  test "should destroy logged_day" do
    assert_difference('LoggedDay.count', -1) do
      delete :destroy, id: @logged_day
    end

    assert_redirected_to logged_days_path
  end
end
