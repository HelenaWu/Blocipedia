require 'rails_helper'

feature 'premium user registers', js: true do 
  scenario 'successfully ' do
    visit '/'
    click_link 'Sign up'
    click_button 'Upgrade'

    fill_in 'Email', with: 'test@example.org'
    fill_in 'Password', with: 'helloworld'
    fill_in 'Password confirmation', with: 'helloworld'

    click_button "Sign up"
    expect(page).to have_content "Payment confirmation"
    click_button "Enter payment details"

    fill_in 'Number', with: '4242424242424242'
    fill_in 'Expiry Date', with: '01/16'
    fill_in 'Name', with: 'testUser'
    click_button 'Enter'
    expect(page).to have_content "Payment successfully processed."
    expect(page).to have_content "Thanks for upgrading to premium user"
  end
    
end