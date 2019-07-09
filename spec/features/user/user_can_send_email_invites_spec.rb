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
    end
  end
end



# Background: We want to be able to enter a user's Github handle and send them an email invite to our app. You'll use the Github API to retrieve the email address of the invitee.
#
# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
