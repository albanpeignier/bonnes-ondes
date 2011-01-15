require 'spec_helper'

describe ContentFilter do

  let(:episode) { mock(:contents => mock(:find_by_slug => nil), :description => "description") }
  let(:content) { mock "content" }

  subject { ContentFilter.new(episode) }

  describe "content_slugs" do
    
    it "should find 'content:<slug>' in description" do
      subject.stub :description => "abc content:test-1 dummy content:test-2"
      subject.content_slugs.should == %w{test-1 test-2}
    end

  end

  describe "content_references" do
    
    it "should associate content:<slug> with found content" do
      subject.stub :content_slugs => ["slug"]
      episode.contents.should_receive(:find_by_slug).with("slug").and_return(content)
      subject.content_references.should == { "content:slug" => content } 
    end

    it "should associate content:<slug> with nil when no content is found" do
      subject.stub :content_slugs => ["slug"]
      episode.contents.should_receive(:find_by_slug).with("slug").and_return(nil)
      subject.content_references.should == { "content:slug" => nil } 
    end

  end

  describe "description_with_players" do

    let(:view) { mock :audio_player => "audio_player" }
    
    it "should replace content references with html for audio players" do
      subject.stub :content_references => { "content:slug" => content } 
      subject.stub :description => "abc content:slug"
      subject.description_with_players(view).should == "abc audio_player"
    end

  end

end
