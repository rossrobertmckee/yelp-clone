require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "create comment requires logged in" do
    post :create, :place_id => 'omg'
    assert_redirected_to new_user_session_path
  end

  test "create comment needs a valid place_id" do
    u = FactoryGirl.create(:user)
    sign_in u
    post :create, :place_id => 'omg'
    assert_response :not_found
  end

  test "create comment success" do
    u = FactoryGirl.create(:user)
    sign_in u
    place = FactoryGirl.create(:place)
    assert_difference 'place.comments.count' do
      post :create, :place_id => place.id, :comment => {
        :rating  => '1_star',
        :message => 'This place is awful'
      }
    end
    assert_redirected_to place_path(place)
    comment = Comment.last
    assert_equal u, comment.user
  end

  test "create comment validation error" do
    u = FactoryGirl.create(:user)
    sign_in u
    place = FactoryGirl.create(:place)
    assert_no_difference 'place.comments.count' do
      post :create, :place_id => place.id, :comment => {
        :rating  => 'yolo',
        :message => 'This place is awful'
      }
    end
    assert_response :unprocessable_entity
  end

  test "destroy requires you to be logged in" do
    comment = FactoryGirl.create(:comment)
    delete :destroy, :id => comment.id
    assert_redirected_to new_user_session_path
  end

  test "destroy 404 if nothing is there" do
    u = FactoryGirl.create(:user)
    sign_in u
    delete :destroy, :id => u
    assert_response :not_found
  end

  test "admin can destroy comment" do
    u = FactoryGirl.create(:user, :admin => true)
    sign_in u
    comment = FactoryGirl.create(:comment)
    delete :destroy, :id => comment.id
    assert_redirected_to place_path(comment.place)
    assert_nil Comment.find_by_id(comment.id)
  end

  test "author can destroy comment" do
    u = FactoryGirl.create(:user, :admin => false)
    sign_in u
    comment = FactoryGirl.create(:comment, :user => u)
    delete :destroy, :id => comment.id
    assert_redirected_to place_path(comment.place)
    assert_nil Comment.find_by_id(comment.id)
  end

  test "random person cannot destroy a comment" do
    u = FactoryGirl.create(:user, :admin => false)
    sign_in u

    comment = FactoryGirl.create(:comment)
    delete :destroy, :id => comment.id
    assert_response :forbidden

    assert Comment.find_by_id(comment.id).present?
  end
end
