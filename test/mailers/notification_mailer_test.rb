require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "mailer works" do
    ActionMailer::Base.deliveries.clear
    assert ActionMailer::Base.deliveries.empty?

    comment = FactoryGirl.create(:comment)
    NotificationMailer.comment_added(comment).deliver
    email = ActionMailer::Base.deliveries.first

    assert_equal 'A new comment has been added to the application', email.subject
    assert_equal [comment.place.user.email].sort, email.to.sort
    assert_equal ['ken@my-awesome-app.com'], email.from
  end

end
