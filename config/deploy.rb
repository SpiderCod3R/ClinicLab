# config valid only for current version of Capistrano
lock '3.6.1'

set :user, 'deployer'

server '138.197.135.242', port: 49697, roles: [:web, :app, :db], primary: true

set :application, 'gclinic'
set :repo_url, 'git@gitlab.com:gclinic/gclinic2.0.git' # Edit this to match your repository
set :branch, :master
set :deploy_to, "/home/#{fetch(:user)}/globalnetsis/#{fetch(:application)}"
set :pty, true
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :stage,           :production
set :deploy_via,      :remote_cache

set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock" 
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_preload_app, true
set :puma_init_active_record, true

namespace :puma do  
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do  
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end  
