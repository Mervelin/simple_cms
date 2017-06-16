class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :confirm_logged_in

  def confirm_logged_in
    return if session[:user_id]
    flash[:notice] = 'Please log in.'
    redirect_to(access_login_path)
  end
end
