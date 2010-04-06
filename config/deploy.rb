default_run_options[:pty] = true
default_environment['PATH'] = "/opt/ruby-enterprise-1.8.7-2010.01/bin:$PATH"

set :application, "Deesis"
set :repository,  "git://github.com/ready4god2513/Deesis.git"
set :domain, 'deesis.org' 
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/vhosts/deesis.org/rails/deployment/#{application}"
set :use_sudo, false
set :scm_verbose, true
set :user, 'deesis_ftp'

server 'deesis_ftp@deesis.org', :app, :web, :db

role :app, domain 
role :web, domain 
role :db, domain, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  desc "Build the site" 
  
  task :after_update_code, :roles => :web do
    run <<-EOF
      cd #{release_path}
      rake asset:packager:build_all
    EOF
  end
  
  
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
  
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end