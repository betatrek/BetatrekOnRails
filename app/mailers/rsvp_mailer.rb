class RsvpMailer < ActionMailer::Base
  default from: "emailconfirmation@betatrek.com"

  def email_confirmation rsvp
  	@rsvp = rsvp
    mail to: rsvp.email, subject: "Thank you for RSVPing"
  end
end
