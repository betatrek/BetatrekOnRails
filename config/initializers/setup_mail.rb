ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",
	:port                 => 587,
	:domain               => "betatrek.com",
	:user_name            => "emailconfirmation",
	:password             => "thisisabettafish",
	:authentication       => "plain",
	:enable_starttls_auto => true
}