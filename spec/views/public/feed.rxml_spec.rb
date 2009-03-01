require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "public/feed" do

  fixtures :shows, :episodes, :contents
  
  before do
    assigns[:show] = @show = shows(:first)

    @contents = Array.new(3) { mock(Content) }
    template.stub!(:contents_for_feed).and_return(@contents)

    template.stub!(:render).and_return("")
  end

  def render_page
    render "public/feed"
  end

  it "should display show title" do
    @show.stub!(:name).and_return("dummy")
    render_page
    response.should have_tag('title', "dummy")
  end

  it "should use helper contents_for_show to known contents to be displayed" do
    template.should_receive(:contents_for_feed).with(@show).and_return(@contents)
    render_page
  end

  it "should render each content with partial feed_content" do
    @contents.each_with_index do |content, index|
      template.should_receive(:render).with(:partial => "feed_content", :object => content).and_return("<content id=#{index}/>")
    end
    render_page
    @contents.each_with_index { |_,index| response.should have_tag("content[id=?]",index) }
  end

end
