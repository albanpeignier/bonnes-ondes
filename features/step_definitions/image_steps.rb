Given /A image "([^\"]*)" exists for "([^\"]*)" show/i do |title, show_slug|
  @show = Show.find_by_slug(show_slug)
  @image = Factory.create(:image, :title => title, :show => @show)
end

Given /The image "([^\"]*)" for show "([^\"]*)" should not exist/i do |title, show_slug|
  Show.find_by_slug(show_slug).images.find_by_title(title).should be_nil
end

Given /^the following images exist for "([^\"]*)" show$/ do |show_slug, table|
  @show = Show.find_by_slug(show_slug)

  table.hashes.each do |hash|
    Factory.create(:image, hash.dup.update(:show => @show))
  end
end
