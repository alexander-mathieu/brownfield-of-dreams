require 'rails_helper'

RSpec.describe 'as a registered user' do
  context 'when I visit my dashboard' do
    before :each do
      @user = create(:user)

      visit '/'

      click_on 'Sign In'
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: @user.password

      click_on 'Log In'
    end

    it 'I see a link to connect to GitHub' do
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link('Connect to GitHub')
    end

    context 'when I click link to connect to GitHub and complete OAuth process' do
      it 'my dashboard shows GitHub repos/followers/following' do
        OmniAuth.config.test_mode = true

        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: 'github',
          credentials: { token: ENV['GITHUB-TOKEN'] }
        })

        VCR.use_cassette('github_dashboard_oauth') do
          click_on 'Connect to GitHub'

          expect(current_path).to eq(dashboard_path)
          expect(page).to_not have_link('Connect to GitHub')

          within '.github-dashboard' do
            expect(page).to have_css('.github-dashboard-repos')
            expect(page).to have_css('.github-dashboard-followers')
            expect(page).to have_css('.github-dashboard-following')
          end
        end
      end
    end
  end
end
