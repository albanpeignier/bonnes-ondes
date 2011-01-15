puts "Loading factories ..."

Factory.define :user do |u|
  u.sequence(:login) { |n| "username-#{n}" }
  u.sequence(:email) { |n| "dummy#{n}@tryphon.org" }

  password = "password"
  u.password password
  u.password_confirmation password

  u.activated_at Time.now
end

Factory.define :show do |u|
  u.sequence(:slug) { |n| "slug-#{n}" }
  u.name "name"
  u.description "description"
  u.users { |users| [users.association(:user)] }
  u.episodes { |episodes| [episodes.association(:episode), episodes.association(:episode)] }
end

Factory.define :episode do |f|
  f.sequence(:slug) { |n| "episode-#{n}" }
  f.sequence(:order) { |n| n }
  f.title "title"
  f.description "description"
  f.contents { |contents| [contents.association(:content), contents.association(:content)] }
end

Factory.define :content do |f|
  f.sequence(:slug) { |n| "content-#{n}" }
  f.name "name"
  f.principal true
end
  
Factory.define :post do |u|
  u.sequence(:slug) { |n| "slug-#{n}" }
  u.title "name"
  u.description "description"
  u.association :show
end
  
Factory.define :page do |u|
  u.sequence(:slug) { |n| "slug-#{n}" }
  u.title "name"
  u.content "content"
  u.association :show
end
  
Factory.define :image do |u|
  u.title "name"
  u.uploaded_data TestUploadedFile.new("#{File.dirname(__FILE__)}/fixtures/image.jpg", "image/jpeg")
  u.association :show
end
  
Factory.define :template do |f|
  f.name "Test"
  f.slug "test"
  f.scm_url "dummy"
end
