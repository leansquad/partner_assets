set :rails_env, 'production'
set :deploy_to, "/var/data/www/apps/paa_#{application}_#{rails_env}"

server 'scost.adility.com', :app, :web, :db, primary: true
