require 'spec_helper'

feature 'Assigning permissions' do

  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }
  before do
    sign_in_as!(admin)
    click_link 'Admin'
    click_link 'Users'
    click_link user.email
    click_link 'Permissions'
  end

  scenario 'Viewing a project' do
    check_permission_box 'view', project
    click_button 'Update'
    click_link 'Sign out'
    sign_in_as!(user)
    expect(page).to have_content(project.name)
  end

  scenario 'Viewing a project not permit' do
    click_button 'Update'
    click_link 'Sign out'
    sign_in_as!(user)
    expect(page).to have_no_content(project.name)
  end

end