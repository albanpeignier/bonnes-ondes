# -*- coding: utf-8 -*-
module ContentHelper

  def audio_player(content)
    return "" unless content

    content_tag(:div, :class => "content") do
      content_tag(:p, "#{content.name} (durée #{content.duration} min.)") +
      content_tag(:audio, :controls => "controls", :preload => "none") do
        tag(:source, :type => "audio/mpeg", :src => content.content_url(:format => :mp3)) +
          tag(:source, :type => "audio/ogg; codecs=vorbis", :src => content.content_url(:format => :ogg)) +
          content_tag(:a, "Écouter", :href => url_for_content(content, :mode => :playlist))
      end
    end
  end

end
