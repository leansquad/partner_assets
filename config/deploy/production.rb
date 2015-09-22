set :rails_env, 'production'
set :deploy_to, "/var/data/www/apps/#{application}_#{rails_env}"

server 'scost.adility.com', :app, :web, :db, primary: true
