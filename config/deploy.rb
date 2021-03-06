default_run_options[:pty] = true
set :application, "deesis"
set :repository,  "git@github.com:ready4god2513/Deesis.git"
set :scm, "git"
set :user, "deesis_ftp"
set :branch, "master"
set :deploy_via, :remote_cache
set :use_sudo, false
set :deploy_to, "/var/www/vhosts/deesis.org/httpdocs"


server 'www.deesis.org', :app, :web, :db


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