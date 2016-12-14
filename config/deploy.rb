# config valid only for current version of Capistrano
lock '3.6.1'

set :port, 49697
set :user, 'deployer'
set :deploy_via, :remote_cache
set :pty, true
set :use_sudo, false

server '138.197.135.242',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true


set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: fetch(:user),
  keys: %w(~/.ssh/id_rsa.pub)
}

set :conditionally_migrate, true

set :stage,     :production
set :rails_env, :production
set :application, 'gclinic'
set :repo_url, 'git@gitlab.com:gclinic/gclinic2.0.git'

set :deploy_to, "/home/#{fetch(:user)}/globalnetsis/#{fetch(:application)}"

set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

set :format,    :pretty
set :log_level, :debug

append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/puma.rb'
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb')

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle', 'public/uploads'
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Puma:
set :puma_conf, "#{shared_path}/config/puma.rb"




before :deploy, "puma:make_dirs"
after "assets:symlink", 'setup:database'
