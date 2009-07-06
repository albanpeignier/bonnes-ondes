require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/new.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:post] = @post = Factory.build(:post)
  end

  it "should render new form" do
    render "/posts/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_show_posts_path(@post.show)) do
      with_tag("input#post_title[name=?]", "post[title]")
      with_tag("input#post_slug[name=?]", "post[slug]")
      with_tag("textarea#post_description[name=?]", "post[description]")
    end
  end
end


