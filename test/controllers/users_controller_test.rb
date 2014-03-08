require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "show found" do
      u = FactoryGirl.create(:user)
      get :show, :id => u.id
      assert_response :success
  end

  test "show not found" do
    get :show, :id => 'omg'
    assert_response :not_found
  end


end
