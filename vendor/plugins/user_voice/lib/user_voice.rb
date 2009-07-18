class UserVoice

  attr_accessor :key, :host, :forum
  attr_accessor :alignment, :background_color, :text_color, :hover_color, :lang
  
  def initialize(attributes = {})
    update_attributes(attributes) unless attributes.blank?
  end

  def update_attributes(attributes)
    attributes.each_pair do |key, value|
      send("#{key}=",value)
    end
    self
  end

  @default = nil
  cattr_accessor :default

  def self.config
    account = UserVoice.new
    yield account
    self.default=account
  end

end
