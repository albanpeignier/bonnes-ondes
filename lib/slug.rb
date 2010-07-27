# -*- coding: utf-8 -*-
class Slug
  def self.slugify(text, length = 30)
    return "" if text.nil? or text.strip.blank?
    reduce_separators(replace_specials(text.downcase).gsub(/[^a-z0-9-]+/, ' ').strip.gsub(' ','-')[0..length-1])
  end

  private

  def self.reduce_separators(text)
    while text.include? '--'
      text = text.gsub('--','-')
    end
    text
  end

  def self.replace_specials(text)
    text.gsub(/[éêè]/,"e").gsub("à","a").gsub("ù","u").gsub("ç","c")
  end

end
