# config valid only for current version of Capistrano


set :application, "webelfs"
set :repo_url, "https://github.com/kmucheru/SiteNuts.git"

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/webelfs"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
Capistrano::Configuration.instance.load do

  namespace :deploy do

    namespace :db do

      desc <<-DESC
        Creates the database.yml configuration file in shared path.
        By default, this task uses a template unless a template \
        called database.yml.erb is found either is :template_dir \
        or /config/deploy folders. The default template matches \
        the template for config/database.yml file shipped with Rails.
        When this recipe is loaded, db:setup is automatically configured \
        to be invoked after deploy:setup. You can skip this task setting \
        the variable :skip_db_setup to true. This is especially useful \
        if you are using this recipe in combination with \
        capistrano-ext/multistaging to avoid multiple db:setup calls \
        when running deploy:setup for all stages one by one.
      DESC
      task :setup, :except => { :no_release => true } do

        default_template = <<-EOF
        base: &base
          adapter: sqlite3
          timeout: 5000
        

        production:
          database: #{shared_path}/db/production.sqlite3
          <<: *base
        EOF

        location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
        template = File.file?(location) ? File.read(location) : default_template

        config = ERB.new(template)

        run "mkdir -p #{shared_path}/db"
        run "mkdir -p #{shared_path}/config"
        put config.result(binding), "#{shared_path}/config/database.yml"
      end

      desc <<-DESC
        [internal] Updates the symlink for database.yml file to the just deployed release.
      DESC
      task :symlink, :except => { :no_release => true } do
        run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      end

    end

    after "deploy:setup",           "deploy:db:setup"   unless fetch(:skip_db_setup, false)
    after "deploy:finalize_update", "deploy:db:symlink"

  end

end
