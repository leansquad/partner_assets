set :rails_env, 'qa'
set :deploy_to, "/var/data/www/apps/#{application}_#{rails_env}"

server 'scost.qa.adility.com', :app, :web, :db, primary: true
