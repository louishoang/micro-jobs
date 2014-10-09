FactoryGirl.define do
  factory :user_skill_association do
    association :user
    association :skill
  end
end
