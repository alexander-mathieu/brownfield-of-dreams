# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As registered User with unconfirmed email', type: :feature do
  context 'I register' do
    before :each do
      email = 'dangerzone@aol.com'
      first_name = 'Kenny'
      last_name = 'Loggins'
      password = 'password'

      visit register_path

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'
    end

    it 'and see messages on my dashboard and not have access to account features' do
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
  end

  context 'I sign in to my existing account' do
    it 'and see the Please Check Your Email message'
  end
end
