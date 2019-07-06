class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  # instance methods

  def connect_github(auth_hash)
    update_attributes(github_token: auth_hash[:credentials][:token])
    update_attributes(github_uid: auth_hash[:uid])
  end

  def friendships?
    friendships.count > 0
  end
end
