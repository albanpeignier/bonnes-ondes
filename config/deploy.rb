set :application, "bonnes-ondes"
set :scm, "git"
set :repository, "git://projects.tryphon.eu/bonnes-ondes"

set :deploy_to, "/var/www/bonnes-ondes"

set :keep_releases, 5
after "deploy:update", "deploy:cleanup" 
set :use_sudo, false

set :synchronous_connect, true

server "zigmun.tryphon.org", :app, :web, :db, :primary => true

set :mongrel_conf, "bonnes-ondes.conf"

namespace :deploy do
 desc "Custom restart task for mongrel"
  task :restart, :roles => :app, :except => { :no_release => true } do
    sudo "/usr/local/sbin/mongrel_restart #{mongrel_conf}"
  end
end

after "deploy:update_code", "deploy:gems"

namespace :deploy do
  desc "Install gems"
  task :gems, :roles => :app do
    sudo "rake --rakefile=#{release_path}/Rakefile gems:install RAILS_ENV=production"
  end
end

desc "Create data directories"
task :after_setup, :roles => [:app, :web] do
  attachements_shared_dir = File.join(shared_path, "data", "attachments")
  run "umask 02 && mkdir -p #{attachements_shared_dir}"

  templates_shared_dir = File.join(shared_path, "templates")
  run "umask 02 && mkdir -p #{templates_shared_dir}"
end

desc "Link data directories"
task :after_symlink, :roles => [:app, :web] do
  attachements_shared_dir = File.join(shared_path, "data", "attachments")
  attachements_local_dir = File.join(current_path, "public", "attachments")

  run "ln -nfs #{attachements_shared_dir} #{attachements_local_dir}"

  templates_shared_dir = File.join(shared_path, "templates")
  templates_local_dir = File.join(current_path, "templates")

  run "rsync -av #{templates_local_dir}/ #{templates_shared_dir}/"
  run "rm -rf #{templates_local_dir}"

  run "ln -nfs #{templates_shared_dir} #{templates_local_dir}"
end
