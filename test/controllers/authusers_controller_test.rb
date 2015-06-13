require 'test_helper'

class AuthusersControllerTest < ActionController::TestCase
  setup do
    @authuser = authusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authuser" do
    assert_difference('Authuser.count') do
      post :create, authuser: {  }
    end

    assert_redirected_to authuser_path(assigns(:authuser))
  end

  test "should show authuser" do
    get :show, id: @authuser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authuser
    assert_response :success
  end

  test "should update authuser" do
    patch :update, id: @authuser, authuser: {  }
    assert_redirected_to authuser_path(assigns(:authuser))
  end

  test "should destroy authuser" do
    assert_difference('Authuser.count', -1) do
      delete :destroy, id: @authuser
    end

    assert_redirected_to authusers_path
  end
end
