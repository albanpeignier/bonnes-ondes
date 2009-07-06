require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do

  before(:each) do
    @post = Factory(:post)
  end

  it "should presence of show" do
    @post.show = nil
    @post.should have(1).error_on(:show_id)
  end

end
