# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def url_for_show(show)
    url_for({ :controller => "public", :action => "show",
      :show_slug => show.slug })
  end

  def url_for_episode(episode)
    url_for({ :controller => "public", :action => "episode",
      :show_slug => episode.show.slug,
      :episode_slug => episode.slug })
  end

  def url_for_content(content, options = {})
    mode = :content
    if options.is_a? Symbol
      mode = options
    else
      mode = options.delete(:mode) if options[:mode]
    end

    url_for(options.merge({ :controller => "public", :action => mode,
      :show_slug => content.episode.show.slug,
      :episode_slug => content.episode.slug, :content_slug => content.slug }))
  end

  def link_to_show(show)
    link_to(h(show.name), url_for_show(show))
  end

  def link_to_episode(episode)
    link_to(h(episode.title), url_for_episode(episode))
  end

  def link_to_content(name, content, options = {})
    options = { :mode => options } if options.is_a? Symbol
    options[:mode] ||= :content

    html_options = {}
    if options[:popup]
      html_options[:popup] = ["bonnes-ondes-#{content.id}", 'height=300,width=800']
    end
    link_to(name, url_for_content(content, options), html_options)
  end

  def error_messages_for(object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    if object && !object.errors.empty?
      content_tag("div",
        content_tag(options[:header_tag] || "h2", "#{pluralize(object.errors.count, "erreur a été trouvé", "erreurs ont été trouvées")}") +
        content_tag("ul", object.errors.collect { |name, message| content_tag("li", link_to(message, "##{object_name}_#{name}")) }),
        "id" => options[:id] || "errors", "class" => options[:class] || "errors"
      )
    else
      ""
    end
  end

  def format_date(date)
    format = 'le %d/%m/%Y'

    if date.today?
      format = 'à %H:%M'
    end
    if date.yesterday?
      format = 'hier à %H:%M'
    end

    date.strftime(format)
  end

  def textile_editor(*args)
    (super *args) + '<br/><div class="textile_editor_help">Ajouter un lien: "Bonnes Ondes":http://bonnes-ondes.fr</div>'
  end

end
