class Slug
  def self.slugify(text)
    return "" if text.nil? or text.strip.blank?
    replace_specials(text.downcase).gsub(/[^a-z0-9-]+/, ' ').strip.gsub(' ','-')[0..29]
  end
  
  private
  def self.replace_specials(text)
    text.gsub(/[éêè]/,"e").gsub("à","a").gsub("ù","u").gsub("ç","c")
  end
  
end
