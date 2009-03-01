module PublicHelper

  def contents_for_feed(show)
		@show.episodes.collect { |e| e.contents.principal }.flatten
  end

end
