Given /A show "([^\"]*)" exists with name "([^\"]*)"/i do |slug, name|
  @show = Factory.create(:show, 
    :slug => slug,
    :name => name)
  @show.users << @user
end

Given /The show "([^\"]*)" should not exist/i do |slug|
  Show.find_by_slug(slug).should be_nil
end
