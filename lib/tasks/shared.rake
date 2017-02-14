namespace :shared do
  desc "Database setup Tasks"
  namespace :setup do
    namespace :db do |ns|
      desc 'Drop database'
      task :drop do
        Rake::Task["db:drop"].invoke
      end

      desc 'Create database'
      task :create do
        Rake::Task["db:create"].invoke
        puts "Database created with success"
      end

      desc "Migrate content on db_shards/migrate"
      task :migrate do
        Rake::Task["db:migrate"].invoke
        puts "Files on db_shards/migrate successfully migrated"
      end

      desc 'Back one Stage of migration'
      task :rollback do
        Rake::Task["db:rollback"].invoke
      end

      desc 'Migrate de seed file on db_shards'
      task :seed do
        Rake::Task["db:seed"].invoke
      end

      desc "Tells the version of base migration"
      task :version do
        Rake::Task["db:version"].invoke
      end

      namespace :schema do
        task :load do
          Rake::Task["db:schema:load"].invoke
        end

        task :dump do
          Rake::Task["db:schema:dump"].invoke
        end
      end

      namespace :test do
        task :prepare do
          Rake::Task["db:test:prepare"].invoke
        end
      end
      
      # append and prepend proper tasks to all the tasks defined here above
      ns.tasks.each do |task|
        task.enhance ["shared:setup:set_shared_database"] do
          Rake::Task["shared:setup:revert_to_original_config"].invoke
        end
      end
    end
    
    task :set_shared_database do
      # save current vars
      @original_config = {
        env_schema: ENV['SCHEMA'],
        config: Rails.application.config.dup
      }

      # set config variables for custom database
      ENV['SCHEMA'] = "db_shards/schema.rb"
      Rails.application.config.paths['db'] = ["db_shards"]
      Rails.application.config.paths['db/migrate'] = ["db_shards/migrate"]
      Rails.application.config.paths['db/seeds'] = ["db_shards/seeds.rb"]
      Rails.application.config.paths['config/database'] = ["config/databases/database_shared_db.yml"]
    end

    task :revert_to_original_config do
      # reset config variables to original values
      ENV['SCHEMA'] = @original_config[:env_schema]
      Rails.application.config = @original_config[:config]
    end
  end
end