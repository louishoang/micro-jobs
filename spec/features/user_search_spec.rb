require 'rails_helper'

feature 'users search for freelancer and job' do
  scenario 'user search freelancer' do
    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)

    mock_auth_hash_for(user)
    visit root_path
    click_on "Sign in"

    visit users_path
    save_and_open_page
    expect(page).to have_content(user_2.first_name)
    expect(page).to have_content(user_2.address)
  end

  scenario 'user search job' do
    user = FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)

    mock_auth_hash_for(user)
    visit root_path
    click_on "Sign in"

    visit jobs_path

    expect(page).to have_content(job.name)
    expect(page).to have_content(job.location)
  end
end
