module PublicHelper

  def contents_for_feed(show)
    Episode.sort(show.episodes.broadcasted).collect { |e| e.contents.principal }.flatten
  end

end
