class InviteMailer < ApplicationMailer
  def invite_email(user, invitee)
    @user = user
    @invitee = invitee

    mail(to: invitee.email, subject: "#{user.github_login} has invited you to join the Brownfield project!")
  end
end
