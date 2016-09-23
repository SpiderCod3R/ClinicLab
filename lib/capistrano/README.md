> :info: **Comandos úteis no Capistrano**
```ruby
cap bundler:install                # Install the current Bundler environment  
cap bundler:map_bins               # Maps all binaries to use `bundle exec` by default  
cap deploy                         # Deploy a new release
cap deploy:check                   # Check required files and directories exist
cap deploy:check:directories       # Check shared and release directories exist
cap deploy:check:linked_dirs       # Check directories to be linked exist in shared
cap deploy:check:linked_files      # Check files to be linked exist in shared
cap deploy:check:make_linked_dirs  # Check directories of files to be linked exist in shared
cap deploy:check_revision          # checks whether the currently checkout out revision matches the
cap deploy:cleanup                 # Clean up old releases
cap deploy:cleanup_assets          # Cleanup expired assets
cap deploy:cleanup_rollback        # Remove and archive rolled-back release
cap deploy:clobber_assets          # Clobber assets
cap deploy:compile_assets          # Compile assets
cap deploy:compile_assets_locally  # compiles assets locally then rsyncs
cap deploy:finished                # Finished
cap deploy:finishing               # Finish the deployment, clean up server(s)
cap deploy:finishing_rollback      # Finish the rollback, clean up server(s)
cap deploy:initial                 # Initial Deploy
cap deploy:log_revision            # Log details of the deploy
cap deploy:migrate                 # Runs rake db:migrate if migrations are set
cap deploy:migrating               # Runs rake db:migrate
cap deploy:normalize_assets        # Normalize asset timestamps
cap deploy:published               # Published
cap deploy:publishing              # Publish the release
cap deploy:revert_release          # Revert to previous release timestamp
cap deploy:reverted                # Reverted
cap deploy:reverting               # Revert server(s) to previous release
cap deploy:rollback                # Rollback to previous release
cap deploy:rollback_assets         # Rollback assets
cap deploy:set_current_revision    # Place a REVISION file with the current revision SHA in the current release path
cap deploy:started                 # Started
cap deploy:starting                # Start a deployment, make sure server(s) ready
cap deploy:symlink:linked_dirs     # Symlink linked directories
cap deploy:symlink:linked_files    # Symlink linked files
cap deploy:symlink:release         # Symlink release to current
cap deploy:symlink:shared          # Symlink files and directories from shared to release
cap deploy:updated                 # Updated
cap deploy:updating                # Update server(s) by setting up a new release
cap doctor                         # Display a Capistrano troubleshooting report (all doctor: tasks)
cap doctor:environment             # Display Ruby environment details
cap doctor:gems                    # Display Capistrano gem versions
cap doctor:variables               # Display the values of all Capistrano variables
cap install                        # Install Capistrano, cap install STAGES=staging,production
cap monit:reload                   # Reload Monit
cap monit:restart                  # restart Monit
cap monit:start                    # start Monit
cap monit:stop                     # stop Monit
cap nginx:reload                   # nginx: Nginx
cap nginx:remove_default_vhost     # Remove default Nginx Virtual Host
cap nginx:restart                  # nginx: Nginx
cap nginx:start                    # nginx: Nginx
cap nginx:stop                     # nginx: Nginx
cap puma:config                    # Setup Puma config file
cap puma:halt                      # halt puma
cap puma:jungle:add                # Add current project to the jungle
cap puma:jungle:install            # Install Puma jungle
cap puma:jungle:remove             # Remove current project from the jungle
cap puma:jungle:restart            # restart puma
cap puma:jungle:setup              # Setup Puma config and install jungle script
cap puma:jungle:start              # start puma
cap puma:jungle:status             # status puma
cap puma:jungle:stop               # stop puma
cap puma:make_dirs                 # Create Directories for Puma Pids and Socket
cap puma:nginx_config              # Setup nginx configuration
cap puma:phased-restart            # phased-restart puma
cap puma:reload                    # Restart application
cap puma:restart                   # restart puma
cap puma:start                     # Start puma
cap puma:status                    # status puma
cap puma:stop                      # stop puma
cap puma:workers:count             # Add a worker
cap puma:workers:less              # Worker--
cap puma:workers:more              # Worker++
```
