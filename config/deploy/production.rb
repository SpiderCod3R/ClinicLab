set :port, 49697
set :user, 'deployer'
set :deploy_via, :remote_cache
set :use_sudo, false

server '138.197.135.242',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :rbenv_ruby, '2.3.1'
set :rbenv_type, :user

set :conditionally_migrate, true