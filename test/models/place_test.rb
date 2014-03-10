require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "email is sent when a place is save" do
    admin = FactoryGirl.create(:user, :admin => true)
    place = FactoryGirl.build(:place)
    ActionMailer::Base.deliveries.clear
    assert ActionMailer::Base.deliveries.empty?

    assert_difference 'ActionMailer::Base.deliveries.count' do
      place.save
    end

    email = ActionMailer::Base.deliveries.last
    assert_equal 'A new place has been added to the application', email.subject
  end
end
