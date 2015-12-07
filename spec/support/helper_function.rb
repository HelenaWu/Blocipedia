def login(user)
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button('Log in')
end

def login_without_registration(email, password)
    user = FactoryGirl.create(:user, email: email, password: password, password_confirmation: password)
    user.skip_confirmation!
    user.save
    click_link('Sign in')
    login_with_prior_registration(email, password)
end

def login_with_prior_registration(email, password)
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button('Log in')
    expect(page).to have_content "Signed in successfully."
end

def sign_up(email, password)
    click_link 'Sign up'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button "Sign up"  
end

def manual_login_without_reg(email, password)
    sign_up(email, password)
    open_email email
    current_email.click_link "Confirm my account"
    expect(page).to have_content "Your email address has been successfully confirmed."
    login_with_prior_registration(email, password)
end

def fill_in_stripe_field(options)
    fill_in 'Email', with: options["email"]
    page.execute_script(%Q{ $('input#card_number').val("#{options["card_num"]}"); })
    page.execute_script(%Q{ $('input#cc-exp').val("#{options["cc_exp"]}"); })
    fill_in 'CVC', with: options["CVC"]
end