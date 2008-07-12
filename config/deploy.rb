set :application, "bonnes-ondes"
set :repository, "svn+ssh://svn.tryphon.org/private/bonnes-ondes/trunk"

set :deploy_via, :copy
set :copy_strategy, :export

set :deploy_to, "/var/www/bonnes-ondes"

set :keep_releases, 5
set :use_sudo, false

ssh_options[:port] = 2722
set :synchronous_connect, true

role :app, "zigmun.tryphon.org"
role :web, "zigmun.tryphon.org"
role :db,  "zigmun.tryphon.org", :primary => true

set :mongrel_conf, "bonnes-ondes.conf"

namespace :deploy do
 desc "Custom restart task for mongrel"
  task :restart, :roles => :app, :except => { :no_release => true } do
    sudo "/usr/local/sbin/mongrel_restart #{mongrel_conf}"
  end
end

desc "Create data directories"
task :after_setup, :roles => [:app, :web] do
  attachements_shared_dir = File.join(shared_path, "data", "attachments")
  run "umask 02 && mkdir -p #{attachements_shared_dir}"
end

desc "Link data directories"
task :after_symlink, :roles => [:app, :web] do
  attachements_shared_dir = File.join(shared_path, "data", "attachments")
  attachements_local_dir = File.join(current_path, "public", "attachments")

  run "ln -nfs #{attachements_shared_dir} #{attachements_local_dir}"
end
