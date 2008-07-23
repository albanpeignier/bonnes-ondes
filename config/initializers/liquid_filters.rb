module TextFilter
  def textilize(input)
    RedCloth.new(input).to_html
  end
end

Liquid::Template.register_filter(TextFilter)

class Liquid::Drop

  protected

  def view
    @context.registers[:action_view]
  end

end
