require 'development_mail_interceptor'

if Rails.env.production?
	ActionMailer::Base.smtp_settings = {
		:address              => "smtp.sendgrid.com",
		:port                 => 587,
		:domain               => "betatrek.com",
		:user_name            => "bettafish",
		:password             => "deliverybettafish",
		:authentication       => "plain",
		:enable_starttls_auto => true
	}
    ActionMailer::Base.default_url_options[:host] = "ec2-23-20-185-26.compute-1.amazonaws.com"# temporary "betatrek.com"
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

ActionMailer::Base.register_interceptor DevelopmentMailInterceptor if Rails.env.development?