require 'rails_helper'

RSpec.describe 'As a registered user', type: :feature do
  context 'When I visit my dashboard' do
    before :each do
      @user = create(:user, github_token: '12345', github_uid: '09876')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can see a Friendship section' do
      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      within('.friendships') do
        expect(page).to have_content('Friends')
        expect(page).to have_content('You have no friends :(')
      end
    end
  end
end
