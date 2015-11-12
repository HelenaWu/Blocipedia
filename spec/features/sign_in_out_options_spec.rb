require 'rails_helper'

feature 'sign in out options', js: true do 
  scenario 'sign in' do
    visit '/'
    expect(page).not_to have_content "Create new wiki"
    login_without_registration('test@example.org', 'helloworld')
    expect(page).to have_content "Create new wiki"
  end

  scenario 'sign out' do
    visit '/'
    expect(page).to have_content "Create new wiki"
    login_without_registration('test@example.org', 'helloworld')
    expect(page).not_to have_content "Create new wiki"
  end

  scenario 'reset password' do
    visit '/'
    login_without_registration('test@example.org', 'helloworld')
    click_button("Account Settings")
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    fill_in 'Current password', with: 'helloworld'
    expect(page).to have_content "Your account has been updated successfully."
  end
end
