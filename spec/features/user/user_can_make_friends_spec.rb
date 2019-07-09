# frozen_string_literal: true

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

    it 'I can see Add as Friend button on unfriended users' do
      brian = create(:user, github_uid: '43261385')
      patrick = create(:user, github_uid: '32880860')
      kyle = create(:user, github_uid: '46171611')
      ryan = create(:user)

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      within('#github-follower-bplantico') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-follower-patrickshobe') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-follower-kylecornelissen') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-follower-ryanmillergm') do
        expect(page).to_not have_button('Add as Friend')
      end

      within('#github-following-bplantico') do
        expect(page).to have_button('Add as Friend')
      end

      within('#github-following-kylecornelissen') do
        expect(page).to have_button('Add as Friend')
      end
    end

    it 'I can Add a Friend using the button on unfriended users' do
      patrick = create(:user, github_uid: '32880860')

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      VCR.use_cassette('github_dashboard') do
        within('#github-follower-patrickshobe') do
          click_on('Add as Friend')
        end
      end

      expect(current_path).to eq(dashboard_path)

      within('#github-follower-patrickshobe') do
        expect(page).to_not have_button('Add as Friend')
      end
      expect(page).to have_content("Congrats, you are now friends with #{patrick.first_name + ' ' + patrick.last_name}!")

      within('.friendships') do
        expect(page).to have_content(patrick.first_name + ' ' + patrick.last_name)
      end
    end

    it 'I can not add a friend using an invalid user id' do
      patrick = create(:user, github_uid: '32880860')

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      patrick.update!(github_uid: nil)
      patrick.reload

      VCR.use_cassette('github_dashboard') do
        within('#github-follower-patrickshobe') do
          click_on('Add as Friend')
        end
      end

      expect(current_path).to eq(dashboard_path)

      within('#github-follower-patrickshobe') do
        expect(page).to_not have_button('Add as Friend')
      end

      expect(page).to_not have_content("Congrats, you are now friends with #{patrick.first_name + ' ' + patrick.last_name}!")
      expect(page).to have_content('Oops! Something went wrong!')

      within('.friendships') do
        expect(page).to_not have_content(patrick.first_name + ' ' + patrick.last_name)
      end
    end
  end
end
