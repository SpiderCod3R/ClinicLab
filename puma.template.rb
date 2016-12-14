#!/usr/bin/env puma

directory '/home/deployer/www/gclinic/current'
rackup "/home/deployer/www/gclinic/current/config.ru"
environment 'production'

pidfile "/home/deployer/www/gclinic/shared/tmp/pids/puma.pid"
state_path "/home/deployer/www/gclinic/shared/tmp/pids/puma.state"
stdout_redirect '/home/deployer/www/gclinic/current/log/puma.error.log', '/home/deployer/www/gclinic/current/log/puma.access.log', true


threads 4,16

bind 'unix:///home/deployer/www/gclinic/shared/tmp/sockets/gclinic-puma.sock'

workers 0

preload_app!

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/deployer/www/gclinic/current/Gemfile"
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
