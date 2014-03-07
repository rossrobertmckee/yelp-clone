require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  test "index" do
    FactoryGirl.create(:place)
    get :index
    assert_response :success
  end

  test "show found" do
    place = FactoryGirl.create(:place)
    get :show, :id =>  place.id
    assert_response :success
  end

  test "show not found" do
    get :show, :id => 'omglol'
    assert_response :not_found
  end

  test "new not signed in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "new" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :new
    assert_response :success
  end

  test "create not signed in" do
    assert_no_difference 'Place.count' do
      post :create, {:place => {
          :name => 'yolo',
          :description => 'omg',
          :lat => 42.3631519,
          :lng => -71.056098,
        }
      }
    end
    assert_redirected_to new_user_session_path
  end


  test "create" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_difference 'Place.count' do
      post :create, {:place => {
          :name => 'yolo',
          :description => 'omg',
          :lat => 42.3631519,
          :lng => -71.056098,
        }
      }
    end
    assert_redirected_to places_path

    assert_equal 1, user.places.count
  end

  test "create invalid" do
    user = FactoryGirl.create(:user)
    sign_in user


    assert_no_difference 'Place.count' do
      post :create, {:place => {
          :name => '',
          :description => '',
          :lat => nil,
          :lng => nil
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "edit found" do
    place = FactoryGirl.create(:place)
    get :edit, :id => place.id
    assert_response :success
  end

  test "edit not found" do
    get :edit, :id => 'omglol'
    assert_response :not_found
  end

  test "update success" do
    place = FactoryGirl.create(:place, :name => 'omg')
    put :update, :id => place.id, :place => {:name => 'lol'}
    assert_redirected_to places_path
    assert_equal 'lol', place.reload.name
  end

  test "update not found" do
    put :update, {
      :id => 'omg', :place => {:name => 'omg' }
    }
    assert_response :not_found
  end

  test "update validation error" do
    place = FactoryGirl.create(:place)
    put :update, :id => place.id, :place => {:name => '' }
    assert place.reload.name.present?
    assert_response :unprocessable_entity
  end

  test "destroy success" do
    place = FactoryGirl.create(:place)
    delete :destroy, :id => place.id
    assert_redirected_to places_path
    assert_nil Place.find_by_id(place.id)
  end

  test "destroy not found" do
    delete :destroy, :id => 'omg'
    assert_response :not_found
  end

end
