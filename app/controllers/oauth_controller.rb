class OauthController < ApplicationController
  def update
    current_user.connect_github(auth_hash)
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
