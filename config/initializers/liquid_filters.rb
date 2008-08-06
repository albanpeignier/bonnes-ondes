require 'html/document'

module TextFilter
  def textilize(input)
    RedCloth.new(input).to_html
  end

  def strip_tags(input)
    full_sanitizer.sanitize input
  end

  private

  def full_sanitizer
    @full_sanitizer ||= HTML::FullSanitizer.new
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
        format = 'aujourd\'hui à %Hh%M'
      elsif date.yesterday?
        format = 'hier à %Hh%M'
      else
        format = 'le %d %B %Y à %Hh%M'
      end
    end

    # use a fixed strftime (with french month)
    date.strftime_local(format.to_s)
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
