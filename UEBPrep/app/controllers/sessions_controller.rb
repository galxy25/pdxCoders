class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase, password: params[:session][:password])
    if user
      log_in user
      redirect_to edit_user_path(user.id)
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
