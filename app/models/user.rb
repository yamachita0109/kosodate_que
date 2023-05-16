class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # has_many :questions

  # TODO relation
  def self.detail(id)
    User
      .joins('LEFT JOIN user_infos ON users.id = user_infos.user_id')
      .where(users: { id: id })
      .select('users.id, users.email, user_infos.name')
      .first
  end
end
