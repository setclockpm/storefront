# config valid only for Capistrano 3.1
lock '3.4.1'

set :application, 'porthos'
set :repo_url, 'git@github.com:porthoshome/storefront.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
 set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
  after :finishing, :cleanup

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  
end


# Spree extension capistrano tasks
# --------------------------------
# by Christopher Maujean
# 
# These tasks depend on the existence of the extensions hash.
#   The key is name of the directory in vendor/extensions.
#   The value is the git url of the extension.
#
set :extensions, {
  'simple_sales' => 'lib/extensions/'
}
#
# $ cap -T extension
# cap deploy:install_extensions      # Install all the spree extensions th...
# cap extension:simple_sales:install # Install ship_notification extension
# cap extension:simple_sales:remove  # Remove ship_notification extension
# cap extension:simple_sales:update  # update ship_notification extension

namespace :deploy do
  desc "Symlink all the spree extensions that this app requires"
  task :install_extensions, roles: :app do
    extensions.each do |name, location|
      puts "Installing #{name} extension from #{location}"
      run "ln -nfs #{shared_path}/#{location}#{name} #{release_path}/#{location}#{name}"
    end
  end
end

# dynamic set of tasks based on the extension hash above
namespace :extension do
  extensions.each do |name, location|
    namespace name.to_sym do
      desc "Install #{name} extension"
      task :install, :roles => :app do
        run "cd #{current_path} && script/extension install #{location}"
      end
      desc "Remove #{name} extension"
      task :remove, :roles => :app do
        run "cd #{current_path} && script/extension remove #{name}"
      end
      desc "update #{name} extension"
      task :update, :roles => :app do
        run "cd #{current_path} && script/extension install #{location} --force"
      end
    end
  end
end







