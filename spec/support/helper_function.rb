def login_without_registration(email, password)
    create(:user, email: email, password: password)
    # visit root_path
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