require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can_edit?"  do
    u = FactoryGirl.create(:user, :admin => false)
    p = FactoryGirl.create(:place, :user => u)
    assert u.can_edit?(p)

    u2 = FactoryGirl.create(:user, :admin => false)
    assert !u2.can_edit?(p)

    u3 = FactoryGirl.create(:user, :admin => true)
    assert u3.can_edit?(p)
  end

end
