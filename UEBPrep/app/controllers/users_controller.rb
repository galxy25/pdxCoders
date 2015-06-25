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
      log_in @user
      render 'show'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  def edit
    @user = !params[:id].nil? ? User.find(params[:id]) : current_user
  end

  private

  def user_params
    params.permit(:id)
  end

  def create_params
    params.require(:user).permit(:email, :password)
  end

end
