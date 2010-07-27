module PublicHelper
  include ClippyHelper

  def contents_for_feed(show)
    Episode.sort(show.episodes).select(&:broadcasted?).collect do |episode|
      episode.contents.select(&:principal?) 
    end.flatten
  end

end
