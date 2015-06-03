class Api::UserController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :json

  def create
      render json: { errors: 'Not implemented' }, status: 501
  end

  def get
      render json: { errors: 'Not implemented' }, status: 501
  end

end
