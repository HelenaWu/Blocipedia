class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @wikis = Wiki.where(user_id: params[:id])    
  end
end
