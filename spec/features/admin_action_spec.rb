require 'rails_helper'

feature 'admin action' do
  scenario 'admin visits users index' do
    admin = FactoryGirl.create(:user, role: "admin")
    user = FactoryGirl.create(:user)

    mock_auth_hash_for(admin)
    visit root_path
    click_on "Sign in"

    visit '/admin/users'
    expect(page).to have_content(user.user_name)
    expect(page).to have_content("Here is a list of users Mr. Admin")
  end

  scenario 'admin visits jobs index' do
    admin = FactoryGirl.create(:user, role: "admin")
    job = FactoryGirl.create(:job)

    mock_auth_hash_for(admin)
    visit root_path
    click_on "Sign in"

    visit '/admin/jobs'
    expect(page).to have_content("Here is a list of jobs:")
    expect(page).to have_content(job.name)
  end

  scenario 'admin create skills index' do
    admin = FactoryGirl.create(:user, role: "admin")
    skill = FactoryGirl.build(:skill)

    mock_auth_hash_for(admin)
    visit root_path
    click_on "Sign in"

    visit '/skills/new'
    fill_in "Name", with: skill.name
    click_on "Create Skill"

    expect(page).to have_content("Your record has been created successfully!")
  end
end
