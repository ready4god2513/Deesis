default_run_options[:pty] = true
set :repository,  "git@github.com:ready4god2513/Deesis.git"
set :scm, "git"
set :user, "deployer"
set :branch, "master"
set :deploy_via, :remote_cache

role :web, "apache"                          # Your HTTP server, Apache/etc
role :app, "apache"                          # This may be the same as your `Web` server
role :db,  "apache", :primary => true # This is where Rails migrations will run
role :db,  "apache"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end