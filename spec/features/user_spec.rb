require 'rails_helper'

feature "User login using facebook" do
  scenario "user can sign in with Facebook account" do
    user = FactoryGirl.create(:user)
    mock_auth_hash_for(user)

    visit root_path
    click_on "Sign in"

    expect(page).to have_content("Successfully signed in")
  end

  scenario "user can edit profile" do
    user = FactoryGirl.create(:user)
    mock_auth_hash_for(user)

    visit root_path
    click_on "Sign in"

    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Address", with: user.address

    click_on "Update User"

    expect(page).to have_content("User profile is updated successfully")
  end
end
