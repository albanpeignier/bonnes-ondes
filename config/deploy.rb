set :application, "bonnes-ondes"
set :scm, "git"

set :repository, "git://www.tryphon.priv/bonnes-ondes"
set :deploy_to, "/var/www/bonnes-ondes"

set :keep_releases, 5
after "deploy:update", "deploy:cleanup" 
set :use_sudo, false

set :rake, "bundle exec rake"

server "bonnesondes.dbx1.tryphon.priv", :app, :web, :db, :primary => true

after "deploy:update_code", "deploy:symlink_shared", "deploy:gems"

namespace :deploy do
  # Prevent errors when chmod isn't allowed by server
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, releases_path, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "mkdir -p #{dirs.join(' ')} && (chmod g+w #{dirs.join(' ')} || true)"
  end

  desc "Install gems"
  task :gems, :roles => :app do
    run "mkdir -p #{shared_path}/bundle"
    run "cd #{release_path} && bundle install --deployment --path=#{shared_path}/bundle --without=test development cucumber"
  end

  desc "Symlinks shared configs and folders on each release"
  task :symlink_shared, :except => { :no_release => true }  do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/"
    run "ln -nfs #{shared_path}/config/production.rb #{release_path}/config/environments/"

    attachements_shared_dir = File.join(shared_path, "attachments")
    attachements_local_dir = File.join(release_path, "public", "attachments")

    run "ln -nfs #{attachements_shared_dir} #{attachements_local_dir}"

    templates_shared_dir = File.join(shared_path, "templates")
    templates_local_dir = File.join(release_path, "templates")

    run "rsync -a #{templates_local_dir}/* #{templates_shared_dir}/"
    run "rm -rf #{templates_local_dir}"

    run "ln -nfs #{templates_shared_dir} #{templates_local_dir}"
  end
end

desc "Create data directories"
task :after_setup, :roles => [:app, :web] do
  attachements_shared_dir = File.join(shared_path, "attachments")
  run "umask 02 && mkdir -p #{attachements_shared_dir}"

  templates_shared_dir = File.join(shared_path, "templates")
  run "umask 02 && mkdir -p #{templates_shared_dir}"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
