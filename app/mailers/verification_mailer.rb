class VerificationMailer < ApplicationMailer
  def verification_email(user)
    @user = user

    mail to: user.email, subject: 'Brownest Fields Account Verification'
  end
end
