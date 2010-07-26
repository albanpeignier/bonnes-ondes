require 'extras/liquid_view'

class TemplateLiquidEngine
  include Singleton

  def self.init
    new
  end

  def initialize
    register_liquid_view
  end

  def self.templates_directory
    "#{Rails.root}/templates"
  end

  def register_liquid_view
    Liquid::Template.file_system = Liquid::LocalFileSystem.new(self.class.templates_directory)
    ActionView::Template.register_template_handler :liquid, LiquidView
  end

  @@liquid_template_path = nil
  cattr_accessor :liquid_template_path

  def self.clear_cache!
    Rails.logger.info "unload liquid templates"
    liquid_template_path.unload! if liquid_template_path
  end

  def self.register_path(view_path)
    if self.templates_directory == view_path
      Rails.logger.debug "detect liquid template path #{view_path}"
      self.liquid_template_path = view_path
    end
  end

end

module ActionView #:nodoc:
  class Template
    class EagerPath
      def initialize(path)
        super
        @loaded = false
        TemplateLiquidEngine.register_path(self)
      end

      def unload!
        @loaded = false
      end
    end
  end
end
