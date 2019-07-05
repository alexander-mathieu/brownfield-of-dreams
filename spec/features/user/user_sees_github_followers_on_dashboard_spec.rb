require 'rails_helper'

RSpec.describe 'as a registered user' do
  context 'when I visit my dashboard' do
    it 'I see a section for GitHub with followers' do
      user = create(:user, github_token: ENV['GITHUB-TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      within('.github-dashboard') do
        within('.github-dashboard-followers') do
          expect(page).to have_content('Followers')
          expect(page).to have_link('patrickshobe', href: 'https://github.com/patrickshobe')
          expect(page).to have_link('bplantico', href: 'https://github.com/bplantico')
          expect(page).to have_link('kylecornelissen', href: 'https://github.com/kylecornelissen')
          expect(page).to have_link('ryanmillergm', href: 'https://github.com/ryanmillergm')
          expect(page).to have_link('Patrick-Duvall', href: 'https://github.com/Patrick-Duvall')
        end
      end
    end
  end
end
