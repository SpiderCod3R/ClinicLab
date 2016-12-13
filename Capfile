require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/workers' # if you want to control the workers (in cluster mode)
require 'capistrano/puma/jungle'  # if you need the jungle tasks
require 'capistrano/puma/monit'   # if you need the monit tasks
require 'capistrano/puma/nginx'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
Dir.glob('lib/capistrano/tasks/*.cap').each  { |r| import r }
