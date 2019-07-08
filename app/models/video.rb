class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  # validations
  validates_presence_of :position, numericality: { greater_than_or_equal_to: 0 }
end
