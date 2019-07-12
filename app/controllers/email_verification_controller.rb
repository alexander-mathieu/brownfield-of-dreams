class EmailVerificationController < ApplicationController
  def edit
  end

  def update
    user = User.find_by(verification_token: params[:verification_token])

    if user
      user.update_attributes(verified_email: true)
      session[:user_id] = user.id
      flash[:success] = 'Thank you! Your account is now verified!'
    else
      flash[:danger] = 'Something has gone wrong. Please reach out to support.'
    end
    redirect_to dashboard_path
  end
end
