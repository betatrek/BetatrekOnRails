if Rails.env.production?
	require 'rubygems'
	require 'rufus/scheduler'
	require 'chronic'

	scheduler = Rufus::Scheduler.start_new

	scheduler.every '1d', first_at: Chronic.parse('today at 14:30') do
		system 'php /webapps/betatrek/current/script/php/fetch_data.php'	
	end
end