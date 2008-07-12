class Episode < ActiveRecord::Base

  validates_presence_of :order, :message => "Pas de numéro défini"
  validates_uniqueness_of :order, :scope => :show_id, :message => "Un épisode utilise déjà ce numéro"

  validates_presence_of :title, :message => "Pas de titre défini"
  validates_length_of :title, :within => 3..30, :too_short => "Le titre est trop court", :too_long => "Le titre est trop long"

  validates_presence_of :description, :message => "Pas de description définie"

  validates_presence_of :slug, :message => "Pas de lien défini"
  validates_length_of :slug, :within => 3..30, :wrong_length => "Le lien doit contenir entre 3 et 20 lettres"
  validates_format_of :slug, :with => /^[a-z0-9-]*$/, :message => "Le lien ne peut contenir que des minuscules, des chiffres et des tirets"
  validates_uniqueness_of :slug, :scope => :show_id, :message => "Un épisode utilise déjà ce lien"

  belongs_to :show
  validates_presence_of :show_id

  has_many :contents, :dependent => :destroy
  belongs_to :image

end
