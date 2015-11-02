class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError do |e|
    flash[:error] = "Sorry you are not authorized to perform this action."
    redirect_to wiki_index_path
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :tier
  end
end
