require 'rails_helper'

feature 'user roles' do 
  scenario 'test default role' do
    user = create(:user, email: email, password: password)
    user.tier == 'free'
  end

  scenario 'edit other user wiki' do
    #TBD
  end
  
end