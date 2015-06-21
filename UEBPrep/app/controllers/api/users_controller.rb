class Api::UsersController < Api::ApiController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # before_action :authenticate

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
    @user = User.new(:email => create_params[:email] , :password => create_params[:password])

    if @user.save
      render json: {:user => @user, status: 204}
    else
      render json: {:user => nil, status: 500}
    end
  end

  def destroy

  end

  private

  def user_params
    params.permit(:id, :password, :email)
  end

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
