class SessionsController < ApplicationController

  def new
  end

  def create
    users = User.where(username: params[:session][:username])
    #If it's greater than one, we violated the unique email constraint
    #on the user model
    if users.count < 1
      users = User.where(email: params[:session][:username])
    end
    if users.count == 1
      if users.first.valid_password?(params[:session][:password])
        sign_in(users.first)
        redirect_to profile_path
      else
        flash[:alert] = "Incorrect password"
        render 'new'
      end
    else
      flash[:alert] = "No user with that username and password was found"
      render 'new'
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to root_url
  end
end
