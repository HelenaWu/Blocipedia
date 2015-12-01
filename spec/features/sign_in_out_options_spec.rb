require 'rails_helper'

feature 'sign in out options', js: true do 
  scenario 'sign in' do
    visit '/'
    expect(page).not_to have_content "Create new wiki"
    manual_login_without_reg('test@example.org', 'helloworld')
    expect(page).to have_content "Create new wiki"
  end

  scenario 'sign out' do
    visit '/'
    manual_login_without_reg('test@example.org', 'helloworld')
    expect(page).to have_content "Create new wiki"
    click_link "Sign out"
    expect(page).not_to have_content "Create new wiki"
  end

  scenario 'reset password' do
    visit '/'
    manual_login_without_reg('test@example.org', 'helloworld')
    click_link("account_settings")
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    fill_in 'Current password', with: 'helloworld'
    click_button "Update"
    expect(page).to have_content "Your account has been updated successfully."
  end
end
