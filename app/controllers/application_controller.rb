class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  before_action :admin_access

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def to_home_if_logged_in
    redirect_to :root, alert: "You are already logged in" if current_user
  end

  def is_logged_in?
    !current_user.nil?
  end

  private

  def authenticate_user
    redirect_to new_session_path, alert: "Please login first!" unless current_user
  end

  def admin_access
    redirect_to root_path, alert: "Admin access required!" if current_user && !current_user.is_admin?
  end

  def default_report_start_date
    today = Date.today
    today - today.wday
  end

  def default_report_end_date
    Date.today
  end

  helper_method :current_user
  helper_method :is_logged_in?
  helper_method :default_report_start_date
  helper_method :default_report_end_date
end
