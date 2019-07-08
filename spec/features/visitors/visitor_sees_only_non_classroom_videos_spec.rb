# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'When I visit the homepage' do
  before :each do
    @user = create(:user)

    @t1 = create(:tutorial, classroom: true)
    @t2 = create(:tutorial, classroom: true)
    @t3 = create(:tutorial)

    @v1 = create(:video, tutorial: @t1)
    @v2 = create(:video, tutorial: @t1)
    @v3 = create(:video, tutorial: @t2)
    @v4 = create(:video, tutorial: @t2)
    @v5 = create(:video, tutorial: @t3)
    @v6 = create(:video, tutorial: @t3)
  end

  context 'as a visitor' do
    it 'I see a list of available tutorials, excluding those marked as classroom content' do
      visit root_path

      expect(page).to have_css('.tutorial', count: 1)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(@t3.title)
        expect(page).to have_content(@t3.description)
      end
    end

    describe 'and click on the title of a non-classroom tutorial' do
      it 'I can view the tutorial as normal' do
        visit root_path

        click_link @t3.title

        expect(current_path).to eq(tutorial_path(@t3))
      end
    end

    describe 'and try to visit the show page of a classroom tutorial' do
      it "I'm greeted with a 404 error" do
        visit tutorial_path(@t1)

        expect(page).to have_content("The page you were looking for doesn't exist.")

        visit tutorial_path(@t2)

        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end
  end
end
