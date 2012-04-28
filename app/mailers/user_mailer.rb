class UserMailer < ActionMailer::Base
  default from: "emailconfirmation@betatrek.com"

  # Performed before sending the user email address email confirmation
  def email_confirmation user
  	@user = user
  	@user.send_confirmation
    mail to: user.email, subject: "Thanks for Starting an Account"
  end
end
