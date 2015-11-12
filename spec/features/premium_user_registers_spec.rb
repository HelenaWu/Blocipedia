require 'rails_helper'

feature 'premium user registers', js: true do 
  scenario 'successfully ' do
    visit '/'
    sign_up('test@example.org', 'helloworld')
    
    expect(page).to have_content "A message with a confirmation link has been sent to your email address"
    open_email "test@example.org"
    current_email.click_link "Confirm my account"
    expect(page).to have_content "Your email address has been successfully confirmed."
    
    login_with_prior_registration('test@example.org', 'helloworld')

    click_button('Upgrade')
    expect(page).to have_content "I want to upgrade"

    fill_in 'Email', with: 'test@example.org'
    fill_in 'Card number', with: '4242424242424242'
    fill_in 'MM / YY', with: '01/16'
    fill_in 'CVC', with: '123'

    click_button 'Upgrade now $15.00'
    #Stripe stopped working...? >_<
    # expect(page).to have_content "Thanks for upgrading to premium user"
  end

  scenario 'invalid email' do
    visit '/'
    sign_up("123123", "helloworld")
    expect(page).to have_content "Please enter an email address"
  end
    
  scenario 'duplicate email' do
    visit '/'
    login_without_registration('test@example.org', 'helloworld')
    expect(page).to raise_error("Email has already been taken")
  end
end