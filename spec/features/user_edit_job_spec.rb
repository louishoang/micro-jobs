require 'rails_helper'

feature "Only login user can edit jobs" do
  scenario "logined user can edit his/her job" do
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

    click_on "Edit Job Posting"

    click_on "Update Job"

    expect(page).to have_content("Job is updated successfully")
  end

  scenario "unlogined user can NOT edit any job" do
    user = FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)

    visit edit_job_path(job)

    expect(page).to have_content("You need to sign in if you want to do that!")
  end

  scenario "login user can NOT edit others' jobs" do
    user = FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)
    user2 = FactoryGirl.create(:user)

    mock_auth_hash_for(user2)
    visit root_path
    click_on "Sign in"

    visit edit_job_path(job)

    expect(page).to have_content("Sorry, you are not authorized to perform this action!")
  end
end
