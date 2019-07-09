class InviteController < ApplicationController
  def new
  end

  def create
    email = github_service.email_query(params[:github_handle])
    if email
      InviteMailer.invite_email(current_user, email).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:danger] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

  def github_service
    GithubService.new(ENV['GITHUB-TOKEN'])
  end
end
