require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
Dir.glob('lib/capistrano/tasks/*.cap').each  { |r| import r }
