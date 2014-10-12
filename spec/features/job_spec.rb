require 'rails_helper'

feature "Login user can post and see jobs" do
  scenario "login user can post job" do
    user = FactoryGirl.create(:user)
    job = FactoryGirl.build(:job)

    mock_auth_hash_for(user)

    visit root_path
    click_on "Sign in"
    click_on "Post New Job"

    fill_in "Name", with: job.name
    fill_in "Location", with: job.location
    fill_in "Budget", with: job.budget
    fill_in "Description", with: job.description
    click_on "Create Job"

    expect(page).to have_content("Your record has been created successfully!")
  end

  scenario "user who doesn't login won't be able post job" do
    user = FactoryGirl.create(:user)
    job = FactoryGirl.build(:job)

    visit new_job_path

    expect(page).to have_content("You need to sign in if you want to do that!")
  end
end
