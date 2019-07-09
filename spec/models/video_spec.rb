require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of :position }
  end

  describe 'class methods' do
    it 'user_bookmarks' do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial_2.id)
      video_2 = create(:video, tutorial_id: tutorial_1.id)
      video_3 = create(:video, tutorial_id: tutorial_2.id)
      user = create(:user)
      bookmark_1 = create(:user_video, user: user, video: video_1)
      bookmark_2 = create(:user_video, user: user, video: video_2)
      bookmark_3 = create(:user_video, user: user, video: video_3)

      expect(Video.user_bookmarks(user.id)).to eq([video_2, video_1, video_3])
    end
  end
end
