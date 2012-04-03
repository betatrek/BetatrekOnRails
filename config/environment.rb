# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BetatrekOnRails::Application.initialize!

# Stop wrapping input with error div
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
	html_tag
end

#Set up dalli for Passenger
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # Reset Rails's object cache
    # Only works with DalliStore
    Rails.cache.reset if forked

    # Reset Rails's session store
    # If you know a cleaner way to find the session store instance, please let me know
    # ObjectSpace.each_object(ActionDispatch::Session::DalliStore) { |obj| obj.reset }
  end
end