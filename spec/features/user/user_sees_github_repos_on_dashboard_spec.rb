# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'as a registered user' do
  context 'when I visit my dashboard' do
    it 'I see a section for GitHub with five repositories' do
      user = create(:user, github_token: ENV['GITHUB-TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      expect(page).to have_css('.github-dashboard-repo', count: 5)

      within('.github-dashboard') do
        within(first('.github-dashboard-repos')) do
          expect(page).to have_link('brownfield-of-dreams', href: 'https://github.com/alexander-mathieu/brownfield-of-dreams')
        end
      end

      within('.github-dashboard') do
        within('.github-dashboard-repos') do
          expect('brownfield-of-dreams').to appear_before('ionic-frontend')
          expect('ionic-frontend').to appear_before('module_3_diagnostic')
          expect('module_3_diagnostic').to appear_before('little_shop_v2')
          expect('little_shop_v2').to appear_before('small_shop')
        end
      end
    end

    it 'if I have no repos, I see a message telling me so' do
      user = create(:user, github_token: ENV['GITHUB-TOKEN-TEST'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('github_dashboard_test') do
        visit dashboard_path
      end

      within('.github-dashboard') do
        within('.github-dashboard-repos') do
          expect(page).to have_content("You have no repositories :(")
        end
      end
    end

    it "I do not see a GitHub section if I'm missing a GitHub token" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('github_user_repos') do
        visit dashboard_path
      end

      expect(page).to_not have_css('.github-dashboard')
      expect(page).to have_css('.github-dashboard-repo', count: 0)
      expect(page).to_not have_link('ionic-frontend', href: 'https://github.com/ToMarketinc/ionic-frontend')
    end
  end
end
