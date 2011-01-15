Given /A show "([^\"]*)" exists with name "([^\"]*)"/i do |slug, name|
  Factory.create(:show, :slug => slug, :name => name).tap do |show|
    show.users << @user
    store_model(:show, slug, show)
  end
end
