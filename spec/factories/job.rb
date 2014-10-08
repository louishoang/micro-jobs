FactoryGirl.define do
  factory :job do
    name "jobtest"
    address "100 harrison ave, boston, ma"
    employer_id 1
    description "this is a super long description which will be used to test"
  end
end
