require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/show.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:post] = @post = Factory(:post,
      :title => "value for title",
      :slug => "value for slug",
      :description => "value for description"
    )
  end

  it "should render attributes in <p>" do
    render "/posts/show.html.erb"
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ description/)
  end
end

