# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::User do
  before :each do
    attributes = { login: 'Joey Bagodonuts',
                   html_url: 'https://joeytime.com',
                   id: 'dangerous' }

    @user = GitHub::User.new(attributes)
  end

  it 'existance' do
    expect(@user).to be_a(GitHub::User)
  end

  it 'attributes' do
    expect(@user.name).to eq('Joey Bagodonuts')
    expect(@user.html_url).to eq('https://joeytime.com')
  end

  describe 'instance methods' do
    it '#registered?' do
      create(:user, github_uid: 'dangerous')
      unregistered_user = GitHub::User.new(id: '12345')

      expect(@user.registered?).to eq(true)
      expect(unregistered_user.registered?).to eq(false)
    end
  end
end
