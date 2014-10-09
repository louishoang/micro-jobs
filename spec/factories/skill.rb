FactoryGirl.define do
  factory :skill do
    sequence(:name) { |n| "#{n}web development" }
  end
end
