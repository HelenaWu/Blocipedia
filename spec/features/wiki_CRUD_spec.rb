require 'rails_helper'

feature 'wiki CRUD', js: true do 
  scenario 'create new public wiki' do 
    visit '/'
    login_without_registration('test@example.org', 'helloworld')
    click_button('Create new wiki')
    fill_in "Subject", with: 'new subject'
    fill_in "Body", with: 'some text'
    click_button('Post')
    #TBC
  end

  scenario 'update public wiki' do
    
  end

  scenario 'delete public wiki' do
    #lol just realized I never implemented delete feature
  end
  
end