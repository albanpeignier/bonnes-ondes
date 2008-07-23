class Show < ActiveRecord::Base

  has_one :host
  belongs_to :template

  def after_initialize
    self.visit_count ||= 0
  end

  validates_presence_of :name, :message => "Pas de nom défini"
  validates_length_of :name, :within => 3..30, :too_short => "Le nom est trop court", :too_long => "Le nom est trop long"

  validates_presence_of :description, :message => "Pas de description définie"

  validates_presence_of :slug, :message => "Pas de lien défini"
  validates_length_of :slug, :within => 3..30, :wrong_length => "Le lien doit contenir entre 3 et 20 lettres"
  validates_format_of :slug, :with => /^[a-z0-9-]*$/, :message => "Le lien ne peut contenir que des minuscules, des chiffres et des tirets"

  validates_uniqueness_of :slug
  validates_exclusion_of :slug, :in => %w(www ftp assets0 assets1 assets2 assets3), :message => "Ce lien '%s' n'est pas disponible"

  has_and_belongs_to_many :users
  has_many :episodes, :dependent => :destroy, :order => "`order` desc"
  has_many :images, :dependent => :destroy

  belongs_to :logo, :class_name => "Image", :foreign_key => "logo_id"

  def next_episode_order
    current = episodes.inject(0) { |max, episode|
      (not episode.order.nil? and episode.order > max) ? episode.order : max
    }
    current + 1
  end

  def last_update_at
    (self.episodes + [ self ]).collect(&:updated_at).max
  end

end
