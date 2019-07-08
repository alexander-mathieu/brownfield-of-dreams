require 'rails_helper'

RSpec.describe 'When viewing a Tutorial page', type: :feature do
  context 'And the Tutorial does not have any videos' do
    it 'will display a message on the page, and the rendering will not error' do
      tutorial = create(:tutorial)

      visit tutorial_path(tutorial)

      expect(page).to have_content(tutorial.title)
      expect(page).to have_content('There are no videos in this tutorial yet!')
    end
  end
end
