require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Partial public/feed_content" do

  fixtures :contents
  
  before do
    @content = contents(:first)
  end

  def render_partial
    render :partial => "public/feed_content", :object => @content
  end

  it "should display enclosure with content_url" do
    content_url = "http://dummy"
    @content.should_receive(:content_url).with(:format => :mp3).and_return(content_url)
    render_partial
    response.should have_tag("enclosure[url=?][type=audio/mpeg]", content_url)
  end

end
