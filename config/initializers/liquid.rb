require 'extras/liquid_view'

Liquid::Template.file_system = Liquid::LocalFileSystem.new("#{Rails.root}/templates")
ActionView::Template.register_template_handler :liquid, LiquidView
