require 'test_helper'

class CatchesControllerTest < ActionController::TestCase
  setup do
    @catch = catches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catch" do
    assert_difference('Catch.count') do
      post :create, catch: { fish_id: @catch.fish_id, length: @catch.length, weight: @catch.weight }
    end

    assert_redirected_to catch_path(assigns(:catch))
  end

  test "should show catch" do
    get :show, id: @catch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catch
    assert_response :success
  end

  test "should update catch" do
    put :update, id: @catch, catch: { fish_id: @catch.fish_id, length: @catch.length, weight: @catch.weight }
    assert_redirected_to catch_path(assigns(:catch))
  end

  test "should destroy catch" do
    assert_difference('Catch.count', -1) do
      delete :destroy, id: @catch
    end

    assert_redirected_to catches_path
  end
end
