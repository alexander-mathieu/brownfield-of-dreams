class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  before_create :set_verification_token

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  # instance methods

  def connect_github(auth_hash)
    update_attributes(github_token: auth_hash[:credentials][:token])
    update_attributes(github_login: auth_hash[:login])
    update_attributes(github_uid: auth_hash[:uid])
  end

  def friendships?
    friendships.count.positive?
  end

  def friends?(github_user)
    friend = User.find_by(github_uid: github_user.uid)
    friends.include?(friend)
  end

  def email_status
    if verified_email
      'Verified!'
    else
      'This account has not yet been verified. Please check your email.'
    end
  end

  private

  def set_verification_token
    self.verification_token = SecureRandom.urlsafe_base64.to_s
  end
end
