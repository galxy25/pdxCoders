class Api::UsersController < Api::ApiController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate
  skip_before_action :authenticate, only: [:create]

  respond_to :json

  def index
    @users = User.all()
    render json: { :users => @users  , status: 200 }
  end

  def show
    @user = User.where(id: user_params[:id])
    if @user.count > 0
      render json: { :user => @user.first  , status: 200 }
    else
      render json: { :errors => "No user with that id was found" , status: 404}
    end
  end

  def create
    @user = User.new(:email => create_params[:email] , :password => create_params[:password])

    if @user.save
      render json: {:user => @user, status: 204}
    else
      render json: {:errors => "Unable to create a user with the given credentials", status: 500}
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:avatar, :email, :password, :username, :location)
  end

  def create_params
    params.require(:user).permit(:avatar, :email, :password, :username, :location)
  end
end
