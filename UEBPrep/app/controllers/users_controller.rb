class UsersController < ApplicationController
  before_action :authenticate!
  skip_before_action :authenticate!, only: [:create, :new]

  def index
    @users = User.all()
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(:email => create_params[:email] , :password => create_params[:password])

    if @user.save
      respond_to do |format|
        format.html { render 'show'}
        format.json { render json: @user }
      end
    else
      flash[:alert] = 'Unable to create an account with that info. Each email can be linked
                       to only one account, and passwords must be at least 8 characters in length.'
      respond_to do |format|
        format.html { render 'new'}
        format.json {render json: {errors: 'Unable to create a user with the information provided' , status: 400} }
      end
    end
  end

  def update
    @user = current_user
    if @user.update(update_params)
      flash[:notice] = 'Your changes have been saved.'
      respond_to do |format|
        format.html {redirect_to user_path @user}
        format.json { render json: @user }
      end
    else
      flash[:alert] = 'Unable to make updates.'
      respond_to do |format|
        format.html {render 'edit'}
        format.json {render json: {errors: 'Unable to make updates.' , status: 400} }
      end
    end
  end

  def edit
    @user = !params[:id].nil? ? User.find(params[:id]) : current_user
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :email, :password, :username, :location)
  end

  def create_params
    params.require(:user).permit(:avatar, :email, :password, :username, :location)
  end

  def update_params
    params.require(:user).permit(:avatar, :email, :password, :username, :location)
  end

end
