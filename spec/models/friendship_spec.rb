# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :friend_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :friend }
  end

  describe 'instance method' do
    it '#real_friends' do
      user = create(:user)
      friendship = Friendship.new(user: user, friend: user)

      expect(friendship.save).to be(false)
      expect(friendship.errors.messages[:user].first).to eq("I guess I get what I deserve, don't I?")
    end
  end
end
