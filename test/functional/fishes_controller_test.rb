require 'test_helper'

class FishesControllerTest < ActionController::TestCase
  setup do
    @fish = fishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fish" do
    assert_difference('Fishes.count') do
      post :create, fish: { code: @fish.code, english_name: @fish.english_name, family: @fish.family, fishbase_name: @fish.fishbase_name, indonesia_name: @fish.indonesia_name, order: @fish.order, scientific_name: @fish.scientific_name }
    end

    assert_redirected_to fish_path(assigns(:fish))
  end

  test "should show fish" do
    get :show, id: @fish
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fish
    assert_response :success
  end

  test "should update fish" do
    put :update, id: @fish, fish: { code: @fish.code, english_name: @fish.english_name, family: @fish.family, fishbase_name: @fish.fishbase_name, indonesia_name: @fish.indonesia_name, order: @fish.order, scientific_name: @fish.scientific_name }
    assert_redirected_to fish_path(assigns(:fish))
  end

  test "should destroy fish" do
    assert_difference('Fishes.count', -1) do
      delete :destroy, id: @fish
    end

    assert_redirected_to fishes_index_path
  end
end
