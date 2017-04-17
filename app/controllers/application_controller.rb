class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def get_like_id_for_user secret
    Like.find_by(user: current_user, secret: secret).id
  end
  helper_method :get_like_id_for_user

  private
 
  def require_login
    unless current_user
      flash[:error] = ["You must be logged in to access this section"]
      redirect_to new_session_path # halts request cycle
    end
  end

  before_action :require_login


end
