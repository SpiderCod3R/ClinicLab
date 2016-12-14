namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end

    before 'puma:start', :make_dirs
  end

  desc 'Restart application'
  task :reload do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
end
