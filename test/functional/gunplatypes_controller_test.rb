require 'test_helper'

class GunplatypesControllerTest < ActionController::TestCase
  setup do
    @gunplatype = gunplatypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gunplatypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gunplatype" do
    assert_difference('Gunplatype.count') do
      post :create, :gunplatype => @gunplatype.attributes
    end

    assert_redirected_to gunplatype_path(assigns(:gunplatype))
  end

  test "should show gunplatype" do
    get :show, :id => @gunplatype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @gunplatype.to_param
    assert_response :success
  end

  test "should update gunplatype" do
    put :update, :id => @gunplatype.to_param, :gunplatype => @gunplatype.attributes
    assert_redirected_to gunplatype_path(assigns(:gunplatype))
  end

  test "should destroy gunplatype" do
    assert_difference('Gunplatype.count', -1) do
      delete :destroy, :id => @gunplatype.to_param
    end

    assert_redirected_to gunplatypes_path
  end
end
