set :port, 49697
set :user, 'rmweb'
set :deploy_via, :remote_cache
set :use_sudo, false

server '159.203.45.125',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true


set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: fetch(:user),
}

set :rbenv_ruby, '2.3.1'
set :rbenv_type, :user

set :conditionally_migrate, true