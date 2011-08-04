# -*- coding: utf-8 -*-
module ContentHelper

  def audio_player(content)
    return "" unless content

    content_tag(:div, :class => "ui360") do
      content_tag :a, "#{content.name} (durée #{content.duration} min.)", :title => "Ecouter #{content.name}", :href => content.content_url(:format => :mp3)
    end
  end

end
