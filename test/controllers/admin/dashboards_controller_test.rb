require 'test_helper'

class Admin::DashboardsControllerTest < ActionController::TestCase
  test "admin controller" do
    assert @controller.is_a?(AdminController)
  end

  test "show" do
    u = FactoryGirl.create(:user, :admin => true)
    sign_in u
    get :show
    assert_response :success
  end
end
