FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "1234"
    user_name "test@gmail.com"
    first_name "testname"
    last_name "testlastname"
    address "33 harrison ave, boston, ma"
  end
end
