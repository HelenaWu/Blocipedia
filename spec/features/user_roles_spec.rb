require 'rails_helper'

feature 'user roles', js: true do 
  scenario 'test default role' do
    user = create(:user, email: "test@example.org", password: "helloworld")
    expect(user.tier).to eq('free')
  end

  scenario 'edit other user wiki' do
    wiki = build(:wiki)
    wiki.user_id = 2 #wiki of another user
    wiki.save   
    visit '/'
    manual_login_without_reg('test@example.org', 'helloworld')
    #database locked
    click_link 'Discover'
    click_link 'Some wiki title'
    expect(page).not_to have_content("edit")
  end
  
end