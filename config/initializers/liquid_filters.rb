module TextFilter
  def textilize(input)
    RedCloth.new(input).to_html
  end
end

Liquid::Template.register_filter(TextFilter)

module PrettyDateFilter

  def prettydate(input, format = nil)
      date = case input
      when String
        Time.parse(input)
      when Date, Time, DateTime
        input
      else
        return input
      end

      if format.blank?
        if date.today?
          format = "aujourd'hui à %Hh%M"
        end
        if date.yesterday?
          format = 'hier à %Hh%M'
        end
      end

      date.strftime(format.to_s)
    rescue => e
      input
    end


end

Liquid::Template.register_filter(PrettyDateFilter)

class Liquid::Drop

  protected

  def view
    @context.registers[:action_view]
  end

end
