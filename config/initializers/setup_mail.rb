require 'development_mail_interceptor'

# Use SendGrid account for production email client, and Google Apps domain for development
if Rails.env.production?
	ActionMailer::Base.smtp_settings = {
		:address              => "smtp.sendgrid.net",
		:port                 => 587,
		:domain               => "betatrek.com",
		:user_name            => "bettafish",
		:password             => "deliverybettafish",
		:authentication       => "plain",
		:enable_starttls_auto => true
	}
    ActionMailer::Base.default_url_options[:host] = "betatrek.com"
else
	ActionMailer::Base.smtp_settings = {
		:address              => "smtp.gmail.com",
		:port                 => 587,
		:domain               => "betatrek.com",
		:user_name            => "emailconfirmation@betatrek.com",
		:password             => "thisisabettafish",
		:authentication       => "plain",
		:enable_starttls_auto => true
	}
    ActionMailer::Base.default_url_options[:host] = "localhost:3000"
end

# Attach an email interceptor to control where all emails in development are sent
ActionMailer::Base.register_interceptor DevelopmentMailInterceptor if Rails.env.development?