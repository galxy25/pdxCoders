class SessionsController < ApplicationController

  def new
  end

  def create
#<<<<<<< HEAD
#    user = User.find_by(email: params[:session][:email].downcase, password: params[:session][:password])
#    if user
#      log_in user
#      redirect_to edit_user_path(user.id)
#=======
    users = User.where(email: params[:session][:email])
    #If it's greater than one, we violated the unique email constraint
    #on the user model
    if users.count == 1
      if users.first.valid_password?(params[:session][:password])
        sign_in(users.first)
        redirect_to profile_path
      else
        render 'new'
      end
#>>>>>>> development
    else
      render 'new'
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to root_url
  end
end
