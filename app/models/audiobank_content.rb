# -*- coding: utf-8 -*-
class AudiobankContent < Content

  @@audiobank_base_url = "http://audiobank.tryphon.org"
  cattr_accessor :audiobank_base_url

  validates_presence_of :audiobank_id, :message => "Pas d'identifiant AudioBank défini"
  validates_length_of :audiobank_id, :is => 8, :wrong_length => "L'identifiant AudioBank doit faire 8 caractères"
  validates_format_of :audiobank_id, :with => /^[a-z0-9]*$/, :message => "L'identifiant AudioBank ne peut contenir que des minuscules et des chiffres"

  def playlist_url
    cast_url
  end

  def support_format?(format)
    [ :mp3, :ogg ].include? format
  end

  def content_url(options = {})
    options[:format] ||= :ogg
    "#{cast_url}.#{options[:format]}"
  end

  def cast_url
    "#{audiobank_base_url}/casts/#{audiobank_id}"
  end

  def validate
    unless validate_content_type %w{ audio/ogg application/ogg }
      errors.add_to_base("Ce document n'existe pas dans AudioBank")
    end
  end

end
