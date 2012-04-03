# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p125'
set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

set :application, "betatrek"
role :web, "107.20.190.97"                          # Your HTTP server, Apache/etc
role :app, "107.20.190.97"                          # This may be the same as your `Web` server
role :db,  "107.20.190.97", :primary => true # This is where Rails migrations will run

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
#set :scm_passphrase, ""  # The deploy user's password

set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to,   "/webapps/#{application}"

# SSH options
ssh_options[:keys] = ["#{ENV['HOME']}/betatrek.pem"] # aws server cert
ssh_options[:forward_agent] = true

# Capistrano Recipes for managing delayed_job
namespace :delayed_job do
    def rails_env
      fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
    end

    def args
      fetch(:delayed_job_args, "")
    end

    def roles
      fetch(:delayed_job_server_role, :app)
    end

    desc "Stop the delayed_job process"
    task :stop, :roles => lambda { roles } do
      run "cd #{current_path};#{rails_env} script/delayed_job stop"
    end

    desc "Start the delayed_job process"
    task :start, :roles => lambda { roles } do
      run "cd #{current_path};#{rails_env} script/delayed_job start #{args}"
    end

    desc "Restart the delayed_job process"
    task :restart, :roles => lambda { roles } do
      run "cd #{current_path};#{rails_env} script/delayed_job restart #{args}"
    end
end

# If you want to use command line options, for example to start multiple workers,
# define a Capistrano variable delayed_job_args:
#
#   set :delayed_job_args, "-n 2"
#
# Add these callbacks to have the delayed_job process restart when the server
# is restarted:
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"