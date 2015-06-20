class Api::UsersController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :json

  def index
    @users = User.all()
    render json: { :users => @users  , status: 200 }
  end

  def show
    @user = User.find(user_params[:id])
    render json: { :user => @user  , status: 200 }
  end

  def create
      render json: { errors: 'Not implemented' }, status: 501
  end

  def destroy

  end

  private

  def user_params
    params.permit(:id, :password, :email)
  end

end
