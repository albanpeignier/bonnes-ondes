class TemplateGenerator < Rails::Generator::Base

  attr_reader :template

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @template = args.shift
  end

  def manifest
    record do |m|
      m.directory "templates/#{template}"
      m.directory "templates/#{template}/images"
      m.directory "templates/#{template}/javascripts"
      m.directory "templates/#{template}/stylesheets"

      %w{show episode content search}.each do |file|
        if File.exists?("lib/generators/template/templates/#{file}.liquid")
          m.template "#{file}.liquid", "templates/#{template}/#{file}.liquid"
        else
          m.file "empty.liquid", "templates/#{template}/#{file}.liquid"
        end
      end
      %w{reset screen}.each do |file|
        m.file "stylesheets/#{file}.css", "templates/#{template}/stylesheets/#{file}.css"
      end
    end
  end

end
