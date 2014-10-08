require 'rails_helper'

feature "User login using facebook" do
  scenario "user can sign in with Facebook account" do
    user = FactoryGirl.create(:user)
    mock_auth_hash_for(user)

    visit root_path
    click_on "Sign in"
    save_and_open_page
  end
end
