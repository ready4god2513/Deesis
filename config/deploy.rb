set :application, "Deesis"
set :repository,  "git://github.com/ready4god2513/Deesis.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/vhosts/deesis.org/rails/deployment/#{application}"
set :use_sudo, true
set :user, 'root'

server 'root@deesis.org', :app, :web, :db

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  
end