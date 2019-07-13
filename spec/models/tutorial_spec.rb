require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
  end

  describe 'relationships' do
    it { should have_many :videos }
    it { should accept_nested_attributes_for :videos }

    it 'destroys dependent videos' do
      tutorial = create(:tutorial)
      create_list(:video, 4, tutorial: tutorial)

      expect { tutorial.destroy }.to change { Video.count }.by(-4)
    end
  end

  describe 'validations' do
    it { should allow_value('https://i.ytimg.com/vi/fwueifn1368/hqdefault.jpg').for(:thumbnail) }
    it { should_not allow_value('https://i.ytimg.com/vi/&%^@#&%^/hqdefault.jpg').for(:thumbnail) }
  end

  describe 'instance methods' do
    it '#classroom?' do
      t1 = create(:classroom_tutorial)
      t2 = create(:classroom_tutorial)
      t3 = create(:tutorial)

      expect(t1.classroom?).to eq(true)
      expect(t2.classroom?).to eq(true)
      expect(t3.classroom?).to eq(false)
    end
  end

  describe 'class methods' do
    it '.exclude_classroom' do
      create_list(:classroom_tutorial, 4)

      t1 = create(:tutorial)
      t2 = create(:tutorial)

      expect(Tutorial.exclude_classroom).to eq([t1, t2])
    end
  end
end
