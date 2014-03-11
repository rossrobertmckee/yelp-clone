require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "email is sent when a comment is saved" do
    comment = FactoryGirl.build(:comment)
    ActionMailer::Base.deliveries.clear
    assert ActionMailer::Base.deliveries.empty?

    assert_difference 'ActionMailer::Base.deliveries.count' do
      comment.save
    end

    email = ActionMailer::Base.deliveries.last
    assert_equal 'A new comment has been added to the application', email.subject
  end

  test "no one can get the message, it wont be sent" do
    User.destroy_all
    place = FactoryGirl.build(:place, :user => nil)
    comment = FactoryGirl.create(:comment, :place => place)
    ActionMailer::Base.deliveries.clear
    assert ActionMailer::Base.deliveries.empty?

    assert_no_difference 'ActionMailer::Base.deliveries.count' do
      place.save
    end

  end
end
