require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should have_secure_password }
    it { should validate_presence_of :password }

    it { should validate_presence_of :first_name }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many(:videos).through(:user_videos) }
  end

  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to(be_truthy)
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to(be_truthy)
    end
  end

  describe 'instance methods' do
    it '#connect_github' do
      user = create(:user)

      auth_hash = { uid: 12_345_678,
                    credentials: { token: 'b1ria2na3nd4bre5n6na7na8re9th10e11b13est' } }

      expect(user.github_uid).to eq(nil)
      expect(user.github_token).to eq(nil)

      user.connect_github(auth_hash)
      user.reload

      expect(user.github_uid.to_i).to eq(auth_hash[:uid])
      expect(user.github_token).to eq(auth_hash[:credentials][:token])
    end
  end
end
