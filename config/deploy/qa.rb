set :rails_env, 'qa'
set :deploy_to, "/var/data/www/apps/paa_#{application}_#{rails_env}"

server 'scost.qa.adility.com', :app, :web, :db, primary: true
