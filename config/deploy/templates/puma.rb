#!/usr/bin/env puma

directory '/var/www/gclinic/current'
rackup "/var/www/gclinic/current/config.ru"
environment 'production'

pidfile "/var/www/gclinic/shared/tmp/pids/puma.pid"
state_path "/var/www/gclinic/shared/tmp/pids/puma.state"
stdout_redirect '/var/www/gclinic/current/log/puma.error.log', 
                '/var/www/gclinic/current/log/puma.access.log', true


threads 4,16

bind 'unix:///var/www/gclinic/shared/tmp/sockets/gclinic-puma.sock'

workers 0

preload_app!

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/var/www/gclinic/current/Gemfile"
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

