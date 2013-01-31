require 'test_helper'

class LogbooksControllerTest < ActionController::TestCase
  setup do
    @logbook = logbooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logbook" do
    assert_difference('Logbook.count') do
      post :create, logbook: { conditions: @logbook.conditions, date: @logbook.date, fuel: @logbook.fuel, line: @logbook.line, moon: @logbook.moon, net: @logbook.net, optime: @logbook.optime, quantity: @logbook.quantity, sail: @logbook.sail, stime: @logbook.stime, ttime: @logbook.ttime, value: @logbook.value, weight: @logbook.weight }
    end

    assert_redirected_to logbook_path(assigns(:logbook))
  end

  test "should show logbook" do
    get :show, id: @logbook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logbook
    assert_response :success
  end

  test "should update logbook" do
    put :update, id: @logbook, logbook: { conditions: @logbook.conditions, date: @logbook.date, fuel: @logbook.fuel, line: @logbook.line, moon: @logbook.moon, net: @logbook.net, optime: @logbook.optime, quantity: @logbook.quantity, sail: @logbook.sail, stime: @logbook.stime, ttime: @logbook.ttime, value: @logbook.value, weight: @logbook.weight }
    assert_redirected_to logbook_path(assigns(:logbook))
  end

  test "should destroy logbook" do
    assert_difference('Logbook.count', -1) do
      delete :destroy, id: @logbook
    end

    assert_redirected_to logbooks_path
  end
end
