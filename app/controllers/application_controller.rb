class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  def current_user
    current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def current_user_logged_in
  	if current_user
  		redirect_to '/'
  	end
  end

end
