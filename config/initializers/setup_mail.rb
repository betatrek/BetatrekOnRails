require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",
	:port                 => 587,
	:domain               => "betatrek.com",
	:user_name            => "emailconfirmation@betatrek.com",
	:password             => "thisisabettafish",
	:authentication       => "plain",
	:enable_starttls_auto => true
}

# Sets the default host to use to create urls in the ActionMailer based on the environment
if Rails.env.production?
    ActionMailer::Base.default_url_options[:host] = "betatrek.com"
else
    ActionMailer::Base.default_url_options[:host] = "localhost:3000"
end
ActionMailer::Base.register_interceptor DevelopmentMailInterceptor if Rails.env.development?