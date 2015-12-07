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
      options = {
        "email" => 'test@example.org',
        "card_num" => '4242 4242 4242 4242',
        "cc_exp" => '12/16',
        "CVC" => "123"
      }
      fill_in_stripe_field(options)
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