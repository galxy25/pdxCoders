class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate!
    unless session.blank? || user_signed_in?
      redirect_to login_path , :status => 403
    end
  end
end
