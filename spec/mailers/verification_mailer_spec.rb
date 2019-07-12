# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VerificationMailer, type: :mailer do
  describe 'verification_email' do
    before :each do
      @user = create(:user, verified_email: false)
      @mail = VerificationMailer.verification_email(@user)
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq('Brownest Fields Account Verification')
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(['no-reply@brownest-field.herokuapp.com'])
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to match('Thanks for registering! To verify your registration, click the link below!')
    end

    it 'assigns @first_name' do
      expect(@mail.body.encoded).to match(@user.first_name)
    end

    it 'assigns @verification_token' do
      expect(@mail.body.encoded).to match(@user.verification_token)
    end
  end
end
