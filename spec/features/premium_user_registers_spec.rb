require 'rails_helper'

feature 'premium user registers' do 
  scenario 'successfully ', js: true do
    visit '/'
    sign_up('test@example.org', 'helloworld')
    
    expect(page).to have_content "A message with a confirmation link has been sent to your email address"
    open_email "test@example.org"
    current_email.click_link "Confirm my account"
    expect(page).to have_content "Your email address has been successfully confirmed."
    
    login_with_prior_registration('test@example.org', 'helloworld')

    click_link('Upgrade')
    click_button "I want to upgrade"


    within_frame "stripe_checkout_app" do 
      fill_in 'Email', with: 'test@example.org'
      # fill_in 'Card number', :with => "4242424242424242"
      page.execute_script(%Q{ $('input#card_number').val('4242 4242 4242 4242'); })
      page.execute_script(%Q{ $('input#cc-exp').val('12/16'); })
      fill_in 'CVC', with: '123'

      click_button 'Upgrade now $15.00'
    end

    #wait up to 5 seconds
    Capybara.using_wait_time 5.seconds do
      expect(page).to have_content "Payment successfully processed. Thanks for upgrading to premium user."
    end
    user = User.first
    expect(user.tier).to eq('premium')
  end

  scenario 'invalid email' do
    visit '/'
    sign_up("123123", "helloworld")
    expect(page).to have_content "Email is invalid"
  end
    
  scenario 'duplicate email', js: true do
    visit '/'
    manual_login_without_reg('test@example.org', 'helloworld')
    click_link 'Sign out'
    sign_up('test@example.org', 'helloworld')
    expect(page).to have_content("Email has already been taken")
  end
end