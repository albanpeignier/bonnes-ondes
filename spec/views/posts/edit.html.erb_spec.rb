require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/edit.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:post] = @post = Factory(:post)
  end

  it "should render edit form" do
    render "/posts/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_show_post_path(@post.show, @post)}][method=post]") do
      with_tag('input#post_title[name=?]', "post[title]")
      with_tag('input#post_slug[name=?]', "post[slug]")
      with_tag('textarea#post_description[name=?]', "post[description]")
    end
  end
end
