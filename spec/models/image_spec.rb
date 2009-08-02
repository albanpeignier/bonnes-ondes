require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do

  before(:each) do
    @image = Image.new    
  end

  it "should have a french message when size is too large" do
    @image.size = 1.megabyte
    @image.error_on(:size).first.should match(/fichier.*trop grand/)
  end

end
