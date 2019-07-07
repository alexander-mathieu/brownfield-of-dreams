require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'relationships' do
    it { should have_many :videos }
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
