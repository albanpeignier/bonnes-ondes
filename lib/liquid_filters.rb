module LiquidFilters

  def sort_by(input, attribute)
    [input].flatten.sort_by(attribute.to_sym)
  end               

  Template.register_filter(LiquidFilters)

end
