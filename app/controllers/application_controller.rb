class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :store_path

  def store_path
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  private

  def authenticate_user
    redirect_to login_path, alert: "Please login before completing that action." unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
