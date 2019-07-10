require 'rails_helper'

RSpec.describe InviteMailer, type: :mailer do
  describe 'invite_email' do
    before :each do
      @user = create(:user, github_login: 'smelphy_io')

      invitee_info = { login: 'sweetactions',
                       html_url: 'https://github.com/high_voltage_when_we_touch',
                       id: 12345,
                       email: 'sweet@actions.com' }

      @invitee = GitHub::User.new(invitee_info)

      @mail = InviteMailer.invite_email(@user, @invitee)
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq("#{@user.github_login} has invited you to join the Brownfield project!")
      expect(@mail.to).to eq([@invitee.email])
      expect(@mail.from).to eq(['no-reply@brownest-field.herokuapp.com'])
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to match('has invited you to join the Brownest Field project. You can create an account')
    end

    it 'assigns @github_login' do
      expect(@mail.body.encoded).to match(@user.github_login)
    end

    it 'assigns @name' do
      expect(@mail.body.encoded).to match(@invitee.name)
    end

    it 'assigns register_url' do
      expect(@mail.body.encoded).to match('http://localhost:3000/register')
    end
  end
end
