default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "Deesis"
set :repository,  "http://github.com/ready4god2513/Deesis.git"
set :domain, 'deesis.org' 
set :scm, "git"
set :branch, "master"
set :git_shallow_clone, 1
set :deploy_to, "/var/www/vhosts/deesis.org/httpdocs"
set :use_sudo, false
set :user, 'deesis_ftp'

server 'deesis_ftp@deesis.org', :app, :web, :db

role :app, domain 
role :web, domain 
role :db, domain, :primary => true

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