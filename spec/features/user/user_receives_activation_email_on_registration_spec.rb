# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As registered User with unconfirmed email', type: :feature do
  context 'I register' do
    before :each do
      @email = 'dangerzone@aol.com'
      first_name = 'Kenny'
      last_name = 'Loggins'
      password = 'password'

      visit register_path

      fill_in 'user[email]', with: @email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
    end

    it 'and see messages on my dashboard and not have access to account features' do
      click_on 'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Logged in as Kenny Loggins")

      within '#account-details' do
        expect(page).to have_content('This account has not yet been verified. Please check your email.')
      end

      expect(page).to_not have_content('Bookmarked Segments')
      expect(page).to_not have_link('Send an Invite')
      expect(page).to_not have_content('Friends')
      expect(page).to_not have_content('GitHub')
    end

    it 'and I receive an email to verify my account' do
      expect { click_on 'Create Account' }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(current_path).to eq(dashboard_path)
    end

    it 'and when I click on the link in the email' do
      click_on 'Create Account'

      user = User.find_by(email: @email)

      visit email_verification_path(verification_token: user.verification_token)

      expect(user.verified_email). to be false

      click_on 'Verify Account'
      user.reload

      expect(current_path).to eq(dashboard_path)
      expect(user.verified_email).to be true

      expect(page).to have_content('Thank you! Your account is now verified!')

      within '#account-details' do
        expect(page).to have_content('Verified!')
      end

      expect(page).to have_content('Bookmarked Segments')
      expect(page).to have_link('Send an Invite')
      expect(page).to have_content('Friends')
    end
  end

  context 'I sign in to my existing account' do
    it 'and see the Please Check Your Email message' do
      visit login_path

      user = create(:user, verified_email: false)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(page).to have_content("Logged in as #{user.first_name + ' ' + user.last_name}")

      within '#account-details' do
        expect(page).to have_content('This account has not yet been verified. Please check your email.')
      end

      expect(page).to_not have_content('Bookmarked Segments')
      expect(page).to_not have_link('Send an Invite')
      expect(page).to_not have_content('Friends')
      expect(page).to_not have_content('GitHub')
    end
  end
end
