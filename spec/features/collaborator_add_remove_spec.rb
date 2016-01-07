require 'rails_helper'

feature 'collaborator add remove', js:true do
  scenario 'add free user as collaborator to private wiki and edit'   do
    user = create(:user, email: "test@example.org", password: "helloworld", tier: "premium")
    other_user = create(:user, email: "free@example.org", password: "helloworld", tier: "free")
    wiki = create(:wiki, user: user, level: "private")
    collab = create(:collaboration, user: other_user, wiki: wiki)
    login_as(other_user)
    visit wiki_path(wiki)
    click_link 'edit wiki'
    expect(page).to have_content("Edit wiki")
  end

  scenario 'add user to wiki multiple times' do
    user = create(:user, email: "test@example.org", password: "helloworld")
    other_user = create(:user, email: "free@example.org", password: "helloworld")
	wiki = create(:wiki, user: user)
    collab = create(:collaboration, user: other_user, wiki: wiki)
    login_as(user)
    visit edit_wiki_path(wiki)
    #Question: how to write this part of test for add collaborator form where it should be empty because there are only 2 users in DB
    binding.pry
    
  end

  scenario 'remove collaborator verify view privilege' do
  	user = create(:user, email: "test@example.org", password: "helloworld", tier: "premium")
    other_user = create(:user, email: "free@example.org", password: "helloworld", tier: "free")
    wiki = create(:wiki, user: user, level: "public")
    collab = create(:collaboration, user: other_user, wiki: wiki)
    login_as(user)
    visit wiki_path(wiki)
    click_link 'edit wiki'
    click_button 'X'
    logout(user)
    login_as(other_user)
    visit wiki_path(wiki)
    expect(pagd).not_to have_content("edit wiki")
  end


end