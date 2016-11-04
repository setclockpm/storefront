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
 set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :extensions, {
  'spree_simple_sales' => '../spree_simple_sales'
}

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
      # endv
    end
  end
  
end

namespace :images do
  desc "Symlinks and maintains product images."
  after "bundler:install", "images:symlink_images" do
    on roles(:app) do
      puts "\n========== Symlinking product images/thumbnails ==========\n "
      execute "rm -rf #{release_path}/public/spree"
      execute "ln -nfs #{shared_path}/spree #{release_path}/public/spree"
    end
  end
end








