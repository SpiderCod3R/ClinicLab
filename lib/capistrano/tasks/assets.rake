namespace :assets do
  task :symlink do
    on roles(:app), in: :sequence, wait: 5 do
      assets.create_dir
        run <<-CMD
         rm -rf  #{release_path}/public/images/upload &&
         ln -nfs #{shared_path}/upload #{release_path}/public/images/upload
       CMD
    end
  end

  task :create_dir do
    on roles(:app), in: :sequence, wait: 5 do
      run "mkdir -p #{shared_path}/upload"
    end
  end
end
