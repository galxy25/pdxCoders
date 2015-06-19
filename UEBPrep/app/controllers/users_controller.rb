class UsersController < ApplicationController

  def index
    @users = User.all()
  end

  def show
    @user = User.find(user_params[:id])
  end

  private

  def user_params
    params.permit(:id, :password, :email)
  end

end
