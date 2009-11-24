require 'test_helper'

class PrayersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prayers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prayer" do
    assert_difference('Prayer.count') do
      post :create, :prayer => { }
    end

    assert_redirected_to prayer_path(assigns(:prayer))
  end

  test "should show prayer" do
    get :show, :id => prayers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => prayers(:one).to_param
    assert_response :success
  end

  test "should update prayer" do
    put :update, :id => prayers(:one).to_param, :prayer => { }
    assert_redirected_to prayer_path(assigns(:prayer))
  end

  test "should destroy prayer" do
    assert_difference('Prayer.count', -1) do
      delete :destroy, :id => prayers(:one).to_param
    end

    assert_redirected_to prayers_path
  end
end
