require 'rails_helper'

RSpec.describe 'As a logged in User' do
  describe 'when I visit my dashboard' do
    it 'displays github section with five repositories' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette("github_user_repos") do
        visit dashboard_path
      end

      expect(page).to have_content("GitHub Repositories")
      expect(page).to have_link("Repo Number 1")
      expect(page).to have_link("Repo Number 2")
      expect(page).to have_link("Repo Number 3")
      expect(page).to have_link("Repo Number 4")
      expect(page).to have_link("Repo Number 5")
      expect(page).to_not have_link("Repo Number 6")

    end
  end
end
