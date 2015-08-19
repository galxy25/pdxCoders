class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in(@user)
      redirect_to profile_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to signup_path
    end
  end

  def facebook
    #@user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in(@user)
      redirect_to profile_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to signup_path
    end
  end

  def twitter
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => auth.provider.capitalize
      sign_in(@user)
      redirect_to profile_path
    else
      if auth.provider.equal?("Twitter")
        session["devise.twitter_uid"] = request.env["omniauth.auth"]
      end
      redirect_to signup_path
    end
  end
end
