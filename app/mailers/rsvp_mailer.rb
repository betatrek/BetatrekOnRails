class RsvpMailer < ActionMailer::Base
  default from: "emailconfirmation@betatrek.com"

  # Performed before sending the RSVP email confirmation
  def email_confirmation rsvp
  	@rsvp = rsvp
    mail to: rsvp.email, subject: "Thank you for RSVPing"
  end
end
