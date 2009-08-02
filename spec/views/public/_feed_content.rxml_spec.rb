require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Partial public/feed_content" do

  fixtures :contents, :episodes
  
  before do
    @content = contents(:first)
  end

  def render_partial
    render :partial => "public/feed_content", :object => @content
  end

  it "should display enclosure with content url if content is available" do
    @content.stub!(:available?).and_return(true)

    content_url = "http://dummy"
    @content.should_receive(:content_url).with(:format => :mp3).and_return(content_url)
    render_partial
    response.should have_tag("enclosure[url=?][type=audio/mpeg]", content_url)
  end

  it "should not display enclosure if content isn't available" do
    @content.stub!(:available?).and_return(false)

    @content.should_not_receive(:content_url)
    render_partial
    response.should_not have_tag("enclosure")
  end

end
