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

    it '#friendships' do
      user_1 = create(:user)
      user_2 = create(:user)

      user_1.friendships.create!(friend: user_2)

      expect(user_1.friendships?).to eq(true)
      expect(user_2.friendships?).to eq(false)

      user_2.friendships.create!(friend: user_1)

      expect(user_2.friendships?).to eq(true)
    end

    it '#friends?' do
      user_1 = create(:user, github_uid: '12345')
      user_2 = create(:user, github_uid: '54321')
      create(:user, github_uid: '67890')

      github_friend = GitHub::User.new(id: '54321')
      github_not_friend = GitHub::User.new(id: '67890')

      user_1.friendships.create!(friend: user_2)

      expect(user_1.friends?(github_friend)).to eq(true)
      expect(user_1.friends?(github_not_friend)).to eq(false)
    end

    it '#email_status' do
      user_1 = create(:user, verified_email: true)
      user_2 = create(:user, verified_email: false)

      expect(user_1.email_status).to eq('Verified!')
      expect(user_2.email_status).to eq('This account has not yet been verified. Please check your email.')
    end
  end
end
