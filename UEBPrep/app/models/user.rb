class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # The :omniauthable modules make our model omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook] #, :twitter]
  acts_as_paranoid

  extend FriendlyId
  friendly_id :email, use: :slugged

  before_create do |doc|
    doc.api_key = doc.generate_api_key
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

  # This method tries to find an existing user by the provider and uid fields.
  # If no user is found, a new one is created with a random password and some
  # extra information. Note that the first_or_create method automatically sets
  # the provider and uid fields when creating a new user.
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  # If we need to copy data from session whenever a user is initialized before
  # sign up. Allows users to cancel sign up with Facebook and be redirected
  # to "cancel_user_registration_path". This will remove all session data
  # starting with "devise." and the new_with_session hook above will no longer
  # be called.
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
