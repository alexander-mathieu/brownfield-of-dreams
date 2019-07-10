class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownest-field.herokuapp.com'
  layout 'mailer'
end
