require 'rails_helper'

feature 'wiki CRUD', js: true do 
  scenario 'create new public wiki' do 
    visit '/'
    manual_login_without_reg('test@example.org', 'helloworld')
    click_link('Create new wiki')
    fill_in "Subject", with: 'new subject'
    binding.pry
    fill_in "Body", with: 'some text'
    click_button("Post")
    expect(page).to have_content("wiki has been created successfully.")
  end

  scenario 'create new private wiki' do
    user = create(:user, tier: "premium", email: "test@example.org", password: "helloworld")
    visit '/'
    click_link "Sign in"
    login(user)
    click_link "Create new wiki"
    expect(page).to have_select('wiki_level', options: ['public', 'private'])
  end


  scenario 'update public wiki' do
    user = create(:user, email: "test@example.org", password: "helloworld")
    wiki = create(:wiki, user: user)

    visit '/'
    click_link "Sign in"
    login_with_prior_registration("test@example.org", "helloworld")
    click_link "My wikis"
    click_link "Some wiki title" #default wiki title created
    click_link "edit wiki"
    fill_in "Body", with: "updated text"
    click_button "Post"
    expect(page).to have_content("succesfully updated wiki entry.")
  end

  scenario 'delete public wiki' do
    user = build(:user, email: "test@example.org", password: "helloworld")
    user.save
    wiki = build(:wiki)
    wiki.user = user
    wiki.save
    # login_as user
    visit '/'
    click_link "Sign in"
    login_with_prior_registration("test@example.org", "helloworld")
    click_link "My wikis"
    click_link "Some wiki title" #default wiki title created
    click_link "delete wiki"
    expect(page).to have_content("wiki has been removed.")

  end
  
end