require 'rails_helper'

RSpec.describe 'As an Admin user', type: :feature do
  context 'when I visit the new tutorial page' do
    before :each do
      @admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'I can create a new tutorial' do
      visit new_admin_tutorial_path

      fill_in 'tutorial[title]', with: 'How to Learn like a Learner'
      fill_in 'tutorial[description]', with: 'Now with new Learnings!'
      fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/Drqj67ImtxI/hqdefault.jpg'

      click_on 'Save'

      new_tutorial = Tutorial.last
      expect(current_path).to eq(tutorial_path(id: new_tutorial.id))

      expect(page).to have_content('Successfully created tutorial.')

      expect(page).to have_content('How to Learn like a Learner')
      expect(page).to have_content('There are no videos in this tutorial yet!')

      visit root_path

      expect(page).to have_content('Now with new Learnings!')
      expect(page).to have_css("img[src='https://i.ytimg.com/vi/Drqj67ImtxI/hqdefault.jpg']")
    end
  end
end
