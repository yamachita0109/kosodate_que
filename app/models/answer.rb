class Answer < ApplicationRecord
  include Hashid::Rails
  # has_many :replies, class_name: 'Reply', foreign_key: :answer_id
  validates :content,
    presence: true,
    length: { maximum: 2000 }
end
