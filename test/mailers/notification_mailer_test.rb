require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "mailer works" do
    admin1 = FactoryGirl.create(:user, :admin => true, :email => 'yolo@omg.com')
    admin2 = FactoryGirl.create(:user, :admin => true, :email => 'swag@omg.com')
    user1 = FactoryGirl.create(:user, :admin => false, :email => 'lol@omg.com')

    ActionMailer::Base.deliveries.clear
    assert ActionMailer::Base.deliveries.empty?

    place = FactoryGirl.create(:place)
    NotificationMailer.place_added(place).deliver
    email = ActionMailer::Base.deliveries.first

    assert_equal 'A new place has been added to the application', email.subject
    assert_equal [admin1.email, admin2.email].sort, email.to.sort
    assert_equal ['ken@my-awesome-app.com'], email.from
  end
end
