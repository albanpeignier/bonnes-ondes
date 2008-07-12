require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/, :message => "Un email valide pour vous contacter est requis"

  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  before_create :make_activation_code
  before_destroy :delete_shows

  has_and_belongs_to_many :shows

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    user = find_by_login(login)

    if user.nil?
      logger.error("no such user : #{login}")
      return nil
    end

    unless user.activated?
      logger.error("authentication error, user not activated : #{user.login}")
      return nil
    end

    unless user.authenticated?(password)
      logger.error("authentication error, invalid password : #{user.login}")
      return nil
    end

    logger.info("authenticated user : #{user.login}")

    return user
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = random_digest
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Activates the user in the database.
  def activate
    @activated = true
    update_attributes(:activated_at => Time.now.utc, :activation_code => nil)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def activated?
    not activated_at.nil?
  end

  def find_episode(id)
    episode = Episode.find(id)
    raise ActiveRecord::RecordNotFound unless shows.include?(episode.show)
    episode
  end

  def find_content(id)
    content = Content.find(id)
    raise ActiveRecord::RecordNotFound unless shows.include?(content.episode.show)
    content
  end

  def episodes
    shows.collect { |show| show.episodes }.flatten
  end

  protected
    # before filter
    def encrypt_password
      return if password.blank?
      self.salt = random_digest if new_record?
      self.crypted_password = encrypt(password)
    end

    def delete_shows
      Show.delete(shows.delete_if{ |show| show.users.size == 1 })
    end

    def random_digest
     Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end

    def password_required?
      crypted_password.blank? || !password.blank?
    end

    # If you're going to use activation, uncomment this too
    def make_activation_code
      self.activation_code = random_digest
    end

end
