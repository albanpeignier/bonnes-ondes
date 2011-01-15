class ContentFilter

  attr_reader :episode

  def initialize(episode)
    @episode = episode
  end

  def description
    episode.description
  end

  def content_slugs
    description.scan(/content:([a-z0-9-]+)/).flatten.uniq.sort
  end

  def content_references
    references = content_slugs.collect do |slug|
      ["content:#{slug}", episode.contents.find_by_slug(slug)]
    end

    Hash[references]
  end

  def description_with_players(view)
    content_references.inject(description) do |description, pair|
      reference, content = pair
      description.gsub reference, view.audio_player(content)
    end
  end

end
