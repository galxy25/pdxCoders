class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :google_oauth2, :twitter]
  acts_as_paranoid

  has_many :playlists, dependent: :destroy

  # Checks to ensure that username is present, unique and that the length is within 3 and 20
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 1..100 }

  extend FriendlyId
  friendly_id :username, use: :slugged

  before_create do |doc|
    doc.api_key = doc.generate_api_key
  end

  has_attached_file :avatar,
                    styles: { small: "64x64", med: "100x100", large: "200x200" }

  # Validate content type
  validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)
  # Validate filename
  # validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

  scope :active, lambda{ where("updated_at > ?", 1.week.ago) }

  scope :monthly_uniques, lambda{ where("updated_at > ?", 1.month.ago) }

  def online?
    updated_at > 10.minutes.ago
  end

  def last_month?
    updated_at > 1.month.ago
  end

  def last_week?
    updated_at > 1.week.ago
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.extra.raw_info.screen_name #for Twitter
      if !user.username
        #could append a random number string here instead for uniqueness
        user.username = auth.info.name.gsub(/\s+/, "") + auth.uid[0..3]
      end
      user.password = Devise.friendly_token[0,20]
      if !auth.info.email
        user.email = user.username+"@"+auth.provider+".com"
        # or alternately:
        #user.email = user.username+"@example.com"
      else
        user.email = auth.info.email
      end
      #search online omniauth+provider for auth hash info
      #user image provided in auth hash and can be used for user avatar with appropriate integration
    end
  end

end
