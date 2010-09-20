require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class TestContent < Content
end

describe Content do

  before do
    @valid_attributes = { :name => "Test", :slug => "test", :episode_id => 0 }
    @content = TestContent.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @content.should be_valid
  end

  describe "available_end_at" do

    before do
      @content.save!
    end
    
    it "should be nil by default" do
      @content.available_end_at.should be_nil
    end

  end

  describe "available?" do
    
    it "should be true if available_end_at is nil" do
      @content.available_end_at = nil
      @content.should be_available
    end

    it "should be false if available_end_at is in the past" do
      @content.available_end_at = 1.day.ago
      @content.should_not be_available
    end

    it "should be true if available_end_at is in the future" do
      @content.available_end_at = 1.day.from_now
      @content.should be_available
    end

  end

end

describe AudiobankContent do

  it "should validate that the content type is audio/ogg or application/ogg" do
    subject.should_receive(:validate_content_type).with(%w{audio/ogg application/ogg})
    subject.validate
  end

end
