# config valid only for current version of Capistrano
lock '3.6.1'

set :stage,     :production
set :rails_env, :production
set :application, 'gclinic'
set :repo_url, 'git@gitlab.com:gclinic/gclinic2.0.git'
set :pty, true

set :deploy_to, "/home/#{fetch(:user)}/globalnetsis/#{fetch(:application)}"

set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/puma.rb'
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb')

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle', 'public/uploads'
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Puma:
set :puma_conf, "#{shared_path}/config/puma.rb"

before :deploy, "deploy:check_revision"
before :deploy, "puma:make_dirs"
after "assets:symlink", 'setup:database'
after :deploy, 'deploy:cleanup'

namespace :deploy do
  before 'check:linked_files', 'puma:config'
  # before 'check:linked_files', 'puma:nginx_config'
  # after 'puma:smart_restart', 'nginx:restart'
end