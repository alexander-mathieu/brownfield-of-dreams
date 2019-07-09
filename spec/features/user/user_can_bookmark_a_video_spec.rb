require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it 'can view their bookmarks on their dashboard' do
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_2.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)
    video_3 = create(:video, tutorial_id: tutorial_2.id)
    user = create(:user)
    bookmark_1 = create(:user_video, user: user, video: video_1)
    bookmark_2 = create(:user_video, user: user, video: video_2)
    bookmark_3 = create(:user_video, user: user, video: video_3)
    # As a logged in user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit '/dashboard'
    visit dashboard_path
    # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
    within '#bookmarks' do
      # And they should be organized by which tutorial they are a part of
      expect(tutorial_1.title).to appear_before(tutorial_2.title)
      # And the videos should be ordered by their position
      expect(video_2.title).to appear_before(video_1.title)
      expect(video_1.title).to appear_before(video_3.title)
    end
  end
end
