FactoryGirl.define do
  factory :comment do
    message "omg"
    association :user
    association :place
  end
end
