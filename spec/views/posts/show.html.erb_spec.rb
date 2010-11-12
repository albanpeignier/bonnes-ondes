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
    # FIXME no wait to render textilize in view spec
    # can't find' ActionView::Helpers::TextHelper::RedCloth
    template.stub :textilize => "textilized_description"

    render "/posts/show.html.erb"
    response.should have_text(/value\ for\ title/)
    response.should have_text(/textilized_description/)
  end
end

