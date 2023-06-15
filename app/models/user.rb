class User < ApplicationRecord
  include Hashid::Rails

  #  :confirmable,は一旦外す。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  # has_many :questions

  validates :name,
    length: { maximum: 200 }
  validates :content,
    length: { maximum: 1000 }
  validates :logo,
    length: { maximum: 200 }
  validates :twitter_id,
    length: { maximum: 200 }
  validates :instagram_id,
    length: { maximum: 200 }
  validates :facebook_id,
    length: { maximum: 200 }
  validates :site_url,
    length: { maximum: 200 }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
