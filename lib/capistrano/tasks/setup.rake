namespace :setup do
  task :database do
    on roles(:app), in: :sequence, wait: 5 do
      run "cp #{deploy_to}/#{shared_dir}/database.yml #{release_path}/config/"
    end
  end

  desc "drop the database"
  task :drop_database do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:drop"
        end
      end
    end
  end

  desc "create the database"
  task :create_database do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:create"
        end
      end
    end
  end

  desc "migrate the database"
  task :migrate_database do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:migrate"
          puts "All migrations imported!"
        end
      end
    end
  end

  desc "Seed the database"
  task :seed_database do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
          puts "All data in seeds.rb are now imported. Go Checkout you workbench or wharever manager you're using!"
        end
      end
    end
  end
end
