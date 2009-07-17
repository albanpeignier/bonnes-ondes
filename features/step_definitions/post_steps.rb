Given /A post "([^\"]*)" exists for "([^\"]*)" show/i do |slug, show_slug|
  @show = Show.find_by_slug(show_slug)
  @post = Factory.create(:post, :slug => slug, :show => @show)
end

Given /A post "([^\"]*)" with title "([^\"]*)" exists for "([^\"]*)" show/i do |slug, title, show_slug|
  @show = Show.find_by_slug(show_slug)
  @post = Factory.create(:post, :slug => slug, :show => @show, :title => title)
end

Given /The post "([^\"]*)" for show "([^\"]*)" should not exist/i do |slug, show_slug|
  Show.find_by_slug(show_slug).posts.find_by_slug(slug).should be_nil
end

Given /^the following posts exist for "([^\"]*)" show$/ do |show_slug, table|
  @show = Show.find_by_slug(show_slug)

  table.hashes.each do |hash|
    Factory.create(:post, hash.update(:show => @show))
  end
end
