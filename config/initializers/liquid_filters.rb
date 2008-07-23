module TextFilter
  def textilize(input)
    RedCloth.new(input).to_html
  end
end

Liquid::Template.register_filter(TextFilter)

class Liquid::Context
  def url_for_episode(*options)
    @registers[:controller].send(:url_for_episode, *options)
  end
end
