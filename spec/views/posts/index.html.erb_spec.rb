require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/index.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:show] = @show = Factory(:show)
    assigns[:posts] = @posts = Array.new(2) do
      Factory(:post, 
              :show => @show,
              :title => "value for title",
              :slug => "value for slug",
              :description => "value for description")
    end
  end

  it "should render list of posts" do
    render "/posts/index.html.erb"
    @posts.each do |post|
      response.should have_tag("a", post.title)
    end
  end

  it "should render link to show each post" do
    render "/posts/index.html.erb"
    @posts.each do |post|
      response.should have_tag("a[href=?]", admin_show_post_path(@show, post))
    end
  end

end

