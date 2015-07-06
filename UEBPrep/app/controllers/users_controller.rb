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
      log_in @user
      render 'show'
    else
      flash[:alert] = 'Unable to create an account with that info. Each email can be linked
                       to only one account, and passwords must be at least 8 characters in length.'
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your changes have been saved.'
      redirect_to edit_user_path
    else
      flash[:alert] = 'Unable to make updates.'
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
    params.permit(:user, :email, :password)
  end

end
