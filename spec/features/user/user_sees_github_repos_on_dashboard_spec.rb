# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'as a registered user' do
  context 'when I visit my dashboard' do
    it 'I see a section for GitHub with five repositories' do
      user = create(:user, github_token: 'github_token')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end

      within('.github-dashboard') do
        within('.github-dashboard-repos') do
          expect(page).to have_content('Repositories')
          expect(page).to have_link('1903_final', href: 'https://github.com/alexander-mathieu/1903_final')
          expect(page).to have_link('activerecord-obstacle-course', href: 'https://github.com/alexander-mathieu/activerecord-obstacle-course')
          expect(page).to have_link('apollo_14', href: 'https://github.com/alexander-mathieu/apollo_14')
          expect(page).to have_link('backend_prework', href: 'https://github.com/alexander-mathieu/backend_prework')
          expect(page).to have_link('blogger', href: 'https://github.com/alexander-mathieu/blogger')
          expect(page).to_not have_link('brownfield-of-dreams')
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
      expect(page).to_not have_link('1903_final', href: 'https://github.com/alexander-mathieu/1903_final')
      expect(page).to_not have_link('activerecord-obstacle-course', href: 'https://github.com/alexander-mathieu/activerecord-obstacle-course')
      expect(page).to_not have_link('apollo_14', href: 'https://github.com/alexander-mathieu/apollo_14')
      expect(page).to_not have_link('backend_prework', href: 'https://github.com/alexander-mathieu/backend_prework')
      expect(page).to_not have_link('blogger', href: 'https://github.com/alexander-mathieu/blogger')
    end
  end
end
