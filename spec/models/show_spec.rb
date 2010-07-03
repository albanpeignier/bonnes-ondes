require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Show do

  before(:each) do
    @show = Show.new :slug => "test" 
  end

  describe "#default_template" do

    it "should use the template with the same slug if exists" do
      Template.should_receive(:find_by_slug).with(@show.slug).and_return(template_with_same_slug = stub_model(Template))
      @show.default_template.should == template_with_same_slug
    end

    it "should use the Show#default_template by default" do
      @show.default_template.should == Show.default_template
    end
    
  end

  describe ".default_template" do
    
    it "should use cocoa template" do
      Show.default_template.should == Template.find_by_slug('cocoa')
    end

  end

  describe "template" do
    
    it "should use associated template if exists" do
      @show.stub!(:real_template).and_return(stub_model(Template))
      @show.template.should == @show.real_template
    end

    it "should use #default_template if no associated" do
      @show.stub!(:default_template).and_return(stub_model(Template))
      @show.template.should == @show.default_template
    end

  end

end

describe Show::LiquidDropClass do

  class TestLiquidDrop < Show::LiquidDropClass
    attr_accessor :object
    def initialize(object) 
      @object = object
    end
  end

  before(:each) do
    @show = Show.new
    @liquid_drop = TestLiquidDrop.new(@show)
  end

  describe "itpc_url_for_podcast" do
    
    it "should return an itpc url with podcast path" do
      @liquid_drop.stub!(:url_for_podcast).and_return("http://path/to/podcast")
      @liquid_drop.itpc_url_for_podcast.should == "itpc://path/to/podcast"
    end

  end

end
