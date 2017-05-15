namespace :setup do
  desc "migrate the database"
  task :migrate_shared_database do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "shared:setup:db:migrate"
          puts "All migrations imported!"
        end
      end
    end
  end
end
