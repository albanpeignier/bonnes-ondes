module PublicHelper
  include ClippyHelper

  def contents_for_feed(show)
    Episode.sort(show.episodes).select(&:broadcasted?).collect do |episode|
      episode.contents.select(&:principal?) 
    end.flatten
  end

  def items_for_feed(show)
    (contents_for_feed(show) + show.posts).sort_by do |item|
      %w{broadcasted_at created_at}.find do |attribute|
        item.respond_to?(attribute) and item.send(attribute).present?
      end
    end
  end

end
