require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette('github_dashboard') do
        visit dashboard_path
      end
    end

    it "I see a link to 'Send an Invite'" do
      expect(page).to have_link('Send an Invite')
    end

    describe "and click 'Send an Invite'" do
      before :each do
        click_link 'Send an Invite'
      end

      it "I'm navigated to a page with a form to fill in a GitHub handle" do
        expect(current_path).to eq(invite_path)

        expect(page).to have_field(:github_handle)
        expect(page).to have_button('Send Invite')
      end

      describe 'and fill in form with a valid GitHub handle and submit' do
        it "I'm navigated back to my dashboard and see a success message" do
          fill_in :github_handle, with: 'WHomer'

          VCR.use_cassette('send-email-success') do
            click_button 'Send Invite'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content('Successfully sent invite!')
        end
      end

      describe 'and fill in form with valid GitHub handle with no public email' do
        it "I'm navigated back to my dashboard and see a failure message" do
          fill_in :github_handle, with: 'BrennanAyers'

          VCR.use_cassette('send-email-failure') do
            click_button 'Send Invite'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
        end
      end

      describe 'and fill in form with an invalid GitHub handle' do
        it "I'm navigated back to my dashboard and see a failure message" do
          fill_in :github_handle, with: 'sdfgrghwetwertwerwerertewt'

          VCR.use_cassette('send-email-invalid') do
            click_button 'Send Invite'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
        end
      end
    end
  end
end

# Background: We want to be able to enter a user's Github handle and send them an email invite to our app. You'll use the Github API to retrieve the email address of the invitee.

# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
