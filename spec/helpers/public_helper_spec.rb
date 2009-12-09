require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicHelper do

  before(:each) do
    @show = Factory(:show)
  end
  
  it "should use only broadcasted episodes" do
    episode_not_broadcast = @show.episodes.first.tap do |episode|
      episode.contents.each { |c| c.update_attribute(:principal, true) }
      episode.update_attribute(:broadcasted_at, 3.months.from_now)
    end

    helper.contents_for_feed(@show).should_not include(*episode_not_broadcast.contents)
  end
  
end
