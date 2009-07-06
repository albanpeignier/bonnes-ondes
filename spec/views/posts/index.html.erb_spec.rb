require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/index.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:posts] = Array.new(2) do
      Factory(:post, 
              :title => "value for title",
              :slug => "value for slug",
              :description => "value for description")
    end
  end

  it "should render list of posts" do
    render "/posts/index.html.erb"
    response.should have_tag("tr>td", "value for title", 2)
    response.should have_tag("tr>td", "value for slug", 2)
    response.should have_tag("tr>td", "value for description", 2)
  end
end

