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

  context 'as a registered user' do
    it 'I see a list of available tutorials, including those marked as classroom content' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit root_path

      expect(page).to have_css('.tutorial', count: 3)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(@t1.title)
        expect(page).to have_content(@t1.description)
      end
    end

    describe 'a click on any tutorial title' do
      it "I'm able to view that tutorial's show page" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit root_path
        click_link @t1.title

        expect(current_path).to eq(tutorial_path(@t1))

        visit root_path
        click_link @t2.title

        expect(current_path).to eq(tutorial_path(@t2))

        visit root_path
        click_link @t3.title

        expect(current_path).to eq(tutorial_path(@t3))
      end
    end
  end
end
