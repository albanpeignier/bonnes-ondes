# -*- coding: utf-8 -*-
class Episode < ActiveRecord::Base
  acts_as_taggable
  acts_as_rated

  named_scope :broadcasted, lambda { {:conditions => ["broadcasted_at < ?", Time.now] } }
  named_scope :not_broadcasted, lambda { {:conditions => ["broadcasted_at > ?", Time.now] } }

  liquid_methods :show, :title, :description, :image, :contents, :broadcasted_at, :tags, :rating_count, :rating_total, :rating_avg

  validates_presence_of :order, :message => "Pas de numéro défini"
  validates_uniqueness_of :order, :scope => :show_id, :message => "Un épisode utilise déjà ce numéro"

  validates_presence_of :title, :message => "Pas de titre défini"
  validates_length_of :title, :within => 3..40, :too_short => "Le titre est trop court (minimum %d caractères)", :too_long => "Le titre est trop long (maximum %d caractères)"

  validates_presence_of :description, :message => "Pas de description définie"

  validates_presence_of :slug, :message => "Pas de lien défini"
  validates_length_of :slug, :within => 3..30, :wrong_length => "Le lien doit contenir entre 3 et 20 lettres"
  validates_format_of :slug, :with => /^[a-z0-9-]*$/, :message => "Le lien ne peut contenir que des minuscules, des chiffres et des tirets"
  validates_uniqueness_of :slug, :scope => :show_id, :message => "Un épisode utilise déjà ce lien"

  belongs_to :show
  validates_presence_of :show_id

  has_many :contents, :dependent => :destroy
  belongs_to :image

  def broadcasted?
    self.broadcasted_at < Time.now
  end

  def self.sort(episodes)
    if episodes.all?(&:broadcasted_at)
      episodes.sort_by(&:broadcasted_at).reverse
    else
      episodes
    end
  end

end

# TODO move this f... code anywhere else
class Episode::LiquidDropClass

  def url_for
    view.url_for_episode(@object)
  end

  def vote_tag
    view.rate_tag(@object)
  end

  def tags
    @object.tag_list
  end

end
