class UserInfo < ApplicationRecord
  validates :name,
    length: { maximum: 200 }
  validates :birthday,
    length: { maximum: 200 }
  validates :text,
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
