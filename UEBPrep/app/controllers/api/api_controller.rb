class Api::ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :json

  def login
      authenticate
      render json: { :user => @@user , status: 202 }
  end

  private

  def current_user
  # Code to determine the current user based off requeset params
  end

  def authenticate
      @@user = User.where(api_key: api_base_params[:api_key])

      if @@user.count > 0
        @@user = @@user.first
        return true
      else
        render json: {errors: 'No user with that api key was found' , status: 403}
      end
  end

  def api_base_params
    params.permit(:api_key, :user)
  end

end
