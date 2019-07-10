# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :real_friends
  validates_presence_of :user_id, :friend_id

  private

  def real_friends
    return unless user_id == friend_id
    errors.add :user, "I guess I get what I deserve, don't I?"
  end
end
