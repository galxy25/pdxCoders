class Api::UsersController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :json

  def index
    @users = User.all()

    respond_to do |format|
      format.html
      format.json { render json: @users, status: 204}
    end
  end

  def show
    binding.pry
    @users = User.all()

    respond_to do |format|
      format.html
      format.json { render json: @users, status: 204}
    end
  end

  def create
      render json: { errors: 'Not implemented' }, status: 501
  end

  def destroy

  end

end
