FactoryGirl.define do
  factory :job_skill_association do
    association :job
    association :skill
  end
end
