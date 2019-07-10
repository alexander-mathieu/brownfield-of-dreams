# frozen_string_literal: true

class InviteController < ApplicationController
  def new
  end

  def create
    query = github_service.user_query(params[:github_handle])
    invitee = GitHub::User.new(query)
    if invitee.email
      InviteMailer.invite_email(current_user, invitee).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:danger] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

  def github_service
    GithubService.new(current_user.github_token)
  end
end
