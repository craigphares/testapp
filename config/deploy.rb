#require 'mongrel_cluster/recipes'

default_run_options[:pty] = true

set :application, "testapp"
set :repository,  "git@github.com:craigphares/testapp.git"

set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "deployer"
set :branch, "master"
set :deploy_to, "/var/www/vhosts/testapp.sixoverground.com/rails/#{application}"
set :deploy_via, :remote_cache
#set :use_sudo, false
set :runner, nil

set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

ssh_options[:forward_agent] = true

role :web, "testapp.sixoverground.com"                    # Your HTTP server, Apache/etc
role :app, "testapp.sixoverground.com"                    # This may be the same as your `Web` server
role :db,  "testapp.sixoverground.com", :primary => true  # This is where Rails migrations will run

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