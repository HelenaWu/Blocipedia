require 'rails_helper'

feature 'user roles', js: true do 
  scenario 'edit other user wiki' do
    another_user = create(:user)
    wiki = create(:wiki, user: another_user)
    wiki.save   
    visit '/'
    manual_login_without_reg('test@example.org', 'helloworld')
    click_link 'Discover'
    click_link 'Some wiki title'
    expect(page).not_to have_content("edit")
  end
  
end