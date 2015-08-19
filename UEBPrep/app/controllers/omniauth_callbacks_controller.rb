class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    _provider = auth.provider.split("_")[0].capitalize
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => _provider
      sign_in(@user)
      redirect_to profile_path
    else
      if auth.provder.equal?("google")
        session["devise.google_data"] = request.env["omniauth.auth"]
      end
      redirect_to signup_path
    end
  end

  def facebook
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
      if auth.provider.equal?("twitter")
        session["devise.twitter_uid"] = request.env["omniauth.auth"]
      end
      redirect_to signup_path
    end
  end
end
