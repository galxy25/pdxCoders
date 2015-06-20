class UsersController < ApplicationController

  def index
    @users = User.all()
  end

  def show
    @user = User.friendly.find(user_params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(:email => create_params[:email] , :password => create_params[:password])

    if @user.save
      render 'show'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.permit(:id)
  end

  def create_params
    params.require(:user).permit(:email, :password)
  end

end
