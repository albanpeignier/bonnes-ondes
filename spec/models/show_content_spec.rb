require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Show do

  

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
