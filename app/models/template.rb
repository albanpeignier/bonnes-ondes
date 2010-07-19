# -*- coding: utf-8 -*-
class Template < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :shows

  liquid_methods :slug
  validates_uniqueness_of :slug

  attr_accessor :resources
  before_save :install_resources
  after_destroy :destroy_resources

  def used?
    not shows.empty?
  end

  def resources=(resources)
    @resources = File.expand_path(resources)
  end

  def has_resources?
    File.exists?(resources_dir)
  end

  def install_resources
    if has_resources?
      Dir.chdir(resources_dir) do
        logger.info "Update git template #{scm_url} in #{resources_dir}"
        system "git pull origin master"
      end
    else
      logger.info "Clone git template #{scm_url} in #{resources_dir}"
      system "git clone #{scm_url} #{resources_dir}"
    end
  end

  def destroy_resources
    FileUtils.rm_rf resources_dir if has_resources?
  end

  # validate :check_resources, :if => :resources

  # def install_resources
  #   if check_resources
  #     backup_resources
  #     FileUtils.mkdir resources_dir
  #     Dir.chdir(resources_dir) do
  #       logger.debug "Install #{name} resources in #{resources_dir}"
  #       system "unzip -qq #{resources}"
  #     end
  #   end
  # end

  # def check_resources
  #   errors.add :resources, "Le fichier de resources ne peut être lu" unless system "unzip -qq -t #{resources}"
  # end

  # def backup_resources
  #   return unless File.exists? resources_dir

  #   FileUtils.rm_rf backup_resources_dir if File.exists?(backup_resources_dir)
  #   FileUtils.mv resources_dir, backup_resources_dir
  # end

  def resources_dir
    "#{Rails.root}/templates/#{slug}"
  end

  def backup_resources_dir
    "#{resources_dir}.old"
  end

end

class Template::LiquidDropClass

  def url_for_assets
    "/templates/#{@object.slug}"
  end

  def javascript_include_tag
    view.javascript_include_tag(:defaults, :cache => false).to_s
  end

  def admin_link_tag
    account_link = if view.logged_in?
      view.link_to("Mon compte", :controller => "account", :action => "index")
    else
      view.link_to("S'identifier", :controller => "account", :action => "login")
    end

    "#{account_link} - hébergé par <a href='http://www.bonnes-ondes.fr'>Bonnes Ondes</a>"
  end

end
