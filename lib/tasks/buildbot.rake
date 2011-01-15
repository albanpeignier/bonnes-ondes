namespace :buildbot do
  task :setup do
    unless uptodate?("config/database.yml", "config/database.yml.sample") 
      cp "config/database.yml.sample", "config/database.yml" 
    end
  end
end

task :buildbot => ["buildbot:setup", "db:migrate", "db:test:prepare", "spec", "spec:plugins", "cucumber"]
