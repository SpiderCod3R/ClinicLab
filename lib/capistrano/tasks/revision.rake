namespace :deploy do
  desc "checks if the currently revision matches the remote one we're trying to deploy from"
  task :check_revision do
    branch = fetch(:branch)
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes before deploy."
      exit
    end
  end
end
