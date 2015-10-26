class UserController < ApplicationController
  def show
    @wikis = Wiki.where(user_id: params[:id])    
  end

rescue_from Exception do |e|
  flash[:error] = 'Sorry you are not authorized to view this page'
  redirect_to root_url
end
end
