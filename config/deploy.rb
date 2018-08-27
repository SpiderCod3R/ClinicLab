lock '3.6.1'

set :deploy_via, :remote_cache
set :use_sudo, false
set :conditionally_migrate, true

set :stage,     :production
set :rails_env, :production
set :application, 'gclinic'
set :repo_url, 'git@gitlab.com:gclinic/gclinic2.0.git'
set :branch, 'master'
set :deploy_to, "/var/www/#{fetch(:application)}"
set :scm, :git

set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb','config/nginx.conf')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/gclinic-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

set :pty, true

before :deploy, "deploy:check_revision"
before :deploy, "puma:make_dirs"
after "assets:symlink", 'setup:database'
after :deploy, 'deploy:cleanup'