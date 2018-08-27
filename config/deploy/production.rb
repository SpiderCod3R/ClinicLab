set :port, 50697
set :user, 'mestre'
set :deploy_via, :remote_cache
set :use_sudo, false

server '142.93.68.194',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: fetch(:user),
}

set :rbenv_ruby, '2.4.4'
set :rbenv_type, :user

set :conditionally_migrate, true