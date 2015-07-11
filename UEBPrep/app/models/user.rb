class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  acts_as_paranoid

  extend FriendlyId
  friendly_id :email, use: :slugged

  before_create do |doc|
    doc.api_key = doc.generate_api_key
  end

  has_attached_file :avatar,
                    styles: { small: "64x64", med: "100x100", large: "200x200" }

  # Validate content type
  validates_attachment_content_type :avatar, :content_type => /\Aimage/
  # Validate filename
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
