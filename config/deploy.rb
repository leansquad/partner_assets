require 'capistrano/ext/multistage'
# require 'sidekiq/capistrano'
# require 'capistrano/sidekiq'
# require 'rvm/capistrano'
require 'bundler/capistrano'

require File.expand_path('../../lib/capistrano/recipes/database_yml.rb', __FILE__)
require File.expand_path('../../lib/capistrano/recipes/unicorn.rb', __FILE__)

load 'deploy/assets'

set :application, 'paa'
set :repository,  'git@github.com:leansquad/partner_assets.git'
set :scm, :git

# Tasks executed by deployer user
set :use_sudo, false

# Fetches changes instead of cloning entire repo
set :deploy_via, :remote_cache

# Configure multistage extension
set :stages, %w(production qa sandbox)
set :default_stage, 'qa'

# Credentials
ssh_options[:user] = 'deployer'
ssh_options[:keys] = %w('~/.ssh/pem/scost.pem') # changed in order to fix an issue in net-ssh 2.6.0 (https://github.com/capistrano/capistrano/issues/286)

# Use local keys
ssh_options[:forward_agent] = true

# Every task will be run with this ruby
set :rvm_ruby_string, '2.0.0-p247@scost'

set :normalize_asset_timestamps, false

# set :sidekiq_pid, ->{ "#{ shared_path }/tmp/pids/sidekiq.pid" }

set :branch do
  puts '--------------------------------------------------------------------'
  puts `git status`
  puts '--------------------------------------------------------------------'
  default_branch = `git branch | grep '*' | sed 's/^[^a-zA-Z]*//'`.strip
  default_tag    = `git tag | tail -n 1`.strip
  tag_or_branch = Capistrano::CLI.ui.ask "Tag or branch to deploy (make sure to push it first): [#{default_branch}|#{default_tag}] "
  tag_or_branch = default_branch if tag_or_branch.empty?
  tag_or_branch
end unless fetch(:branch, false)

# before 'deploy:setup', 'rvm:install_rvm'
# before 'deploy:setup', 'rvm:install_ruby'

namespace :deploy do
  namespace :db do
    desc '[internal] Updates the symlink for database.yml file to the just deployed release.'
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
end

namespace :db do
  desc "seed the database"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

  desc "reset the database"
  task :reset do
    run "cd #{current_path}; bundle exec rake db:reset RAILS_ENV=#{rails_env}"
  end
end

after 'deploy:finalize_update', 'deploy:db:symlink'
after 'deploy', 'deploy:migrate', 'deploy:unicorn:restart', 'deploy:cleanup'

# set :whenever_command, 'bundle exec whenever'
# set :whenever_identifier, defer { "#{application}_#{stage}" }
# require 'whenever/capistrano'

require './config/boot'
# require 'airbrake/capistrano'
