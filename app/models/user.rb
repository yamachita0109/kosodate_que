class User < ApplicationRecord
  include Hashid::Rails

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
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

end
