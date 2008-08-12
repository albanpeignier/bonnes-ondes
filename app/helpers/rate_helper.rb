module RateHelper

  def rate_tag(episode, content_div = true)
    content = []

    content << content_tag(:ul, :class => "rate#{episode.rating_avg.to_i}")do
      returning [] do |list|
        (1..5).each do |rating|
          list << content_tag(:li, link_to_remote(rating, {:url => url_for_rating(episode.id, rating) },
              :class => [ star_class(rating), rating_class(rating, episode.rating_avg) ].join(' '), :name => "#{rating} sur 5"))
        end
      end.join("\n")
    end
    content << content_tag(:span, rating_count_description(episode.rating_count))

    if content_div
      content_tag :div, content, :class => 'rating', :id => "rating-episode-#{episode.id}"
    else
      content
    end
  end

  def url_for_rating(id, rating)
    url_for :controller => "public", :action => "vote", :episode_id => id, :rating => rating
  end

  private

  @@star_classes = %w{one two three four five}

  def star_class(rating)
    @@star_classes[rating - 1]
  end

  def rating_class(rating, rating_avg)
    (rating_avg and rating <= rating_avg) ? "on" : "off"
  end

  def rating_count_description(rating_count)
    case rating_count
      when 0
      when nil
        "aucun vote"
      when 1
        "un vote"
      else
        "#{rating_count} votes"
    end
  end

end
