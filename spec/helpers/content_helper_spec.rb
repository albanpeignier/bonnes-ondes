require 'spec_helper'

describe ContentHelper do

  let(:content) { AudiobankContent.new }

  describe "audio_player" do

    let(:content_playlist) { "/content.m3u" }

    before(:each) do
      helper.stub :url_for_content => content_playlist
    end

    it "should return an audio tag" do
      helper.audio_player(content).should have_tag("audio")
    end

    it "should enable controls" do
      helper.audio_player(content).should have_tag("audio[controls=controls]")
    end

    it "should preload metadata" do
      helper.audio_player(content).should have_tag("audio[preload=none]")
    end

    it "should include a source for mp3 content (with type 'audio/mpeg')" do
      helper.audio_player(content).should have_tag("audio") do
        with_tag("source[type=audio/mpeg][src=?]", content.content_url(:format => :mp3))
      end
    end

    it "should include a source for ogg content (with type 'audio/ogg; codecs=vorbis')" do
      helper.audio_player(content).should have_tag("audio") do
        with_tag("source[type=audio/ogg; codecs=vorbis][src=?]", content.content_url(:format => :ogg))
      end
    end

    it "should include a link to playlist as default" do
      helper.should_receive(:url_for_content).with(content, :mode => :playlist).and_return(content_playlist)
      helper.audio_player(content).should have_tag("audio") do
        with_tag("a[href=?]", content_playlist)
      end
    end

  end
  

end
