unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

Capistrano::Configuration.instance.load do

  namespace :deploy do

    namespace :unicorn do

      desc <<-DESC
        Creates folders
      DESC
      task :setup, :roles => :web, :except => { :no_release => true } do
        run "mkdir -p #{shared_path}/tmp/pids" 
        run "mkdir -p #{shared_path}/tmp/sockets" 
      end
      
      desc <<-DESC
        Restart unicorn
      DESC
      task :restart, :roles => :web, :except => { :no_release => true }, :on_error => :continue do
        run "kill -USR2 `cat #{shared_path}/tmp/pids/unicorn.pid`" 
      end
      
      desc <<-DESC
        Start unicorn
      DESC
      task :start, :roles => :web, :except => { :no_release => true } do
        run "cd #{current_path} && bundle exec unicorn_rails -c #{current_path}/config/unicorn/#{rails_env}.rb -E #{rails_env} -D"
      end
      
      desc <<-DESC
        Stop unicorn
      DESC
      task :stop, :roles => :web, :except => { :no_release => true }, :on_error => :continue do
        run "kill -QUIT `cat #{shared_path}/tmp/pids/unicorn.pid`"
      end

    end

    after "deploy:setup", "deploy:unicorn:setup"

  end

end
