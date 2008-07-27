# French month names
require 'date'

silence_warnings do
  Date.const_set "MONTHNAMES_EN", Date::MONTHNAMES
  Date.const_set "MONTHNAMES", [nil] + %w(Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre)
  Date.const_set "DAYNAMES", %w(Dimanche Lundi Mardi Mercredi Jeudi Vendredi Samedi)
  Date.const_set "ABBR_MONTHNAMES", [nil] + %w(Jan Fév Mar Avr Mai Juin Juil Aoû Sep Oct Nov Dec)
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :long => '%A %d %B %Y' # Lundi 21 Septembre 2007
)
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :time => '%Hh%M' # 18h11
)

class Time

  def strftime_local(format)
    formatted = strftime(format)

    if format.include? '%B'
      Date::MONTHNAMES_EN.each_with_index do |month_en, index|
        formatted = formatted.gsub(month_en, Date::MONTHNAMES[index]) unless month_en.nil?
      end
    end

    formatted
  end

end
