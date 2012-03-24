set :application, "betatrek"

role :web, "ec2-23-20-185-26.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-23-20-185-26.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-23-20-185-26.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start, roles: :app do 
   	run "touch #{current_release}/tmp/restart.txt"
   end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
   	run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:betatrek/BetatrekOnRails"  # Your clone URL
set :scm, "git"
set :user, "ubuntu"  # The server's user for deploys
set :use_sudo, false
#set :scm_passphrase, #"flyingbettafish"  # The deploy user's password

set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to,   "/webapps/#{application}"

# SSH options
ssh_options[:keys] = ["#{ENV['HOME']}/betatrek.pem"] # aws server cert
ssh_options[:forward_agent] = true