require 'spec_helper'

feature 'Profile page' do
  scenario 'viewing' do
    user = FactoryGirl.create(:user)

    visit user_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end
end

feature 'Editing Users' do

  before do
    user = FactoryGirl.create(:user)
    visit user_path(user)
    click_link 'Edit Profile'
  end

  scenario 'Updating a user' do
    fill_in 'Username', with: 'new_username'
    click_button 'Update Profile'
    expect(page).to have_content('Profile has been updated.')
  end

  scenario 'Updating a user with invalid attributes' do
    fill_in 'Username', with: ''
    click_button 'Update Profile'
    expect(page).to have_content('Profile has not been updated.')
  end
end