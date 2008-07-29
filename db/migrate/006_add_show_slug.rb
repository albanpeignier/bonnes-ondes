class AddShowSlug < ActiveRecord::Migration
  def self.up
    add_column :shows, :slug, :string, :null => false, :default => ""
  end

  def self.down
    remove_column :shows, :slug
  end
end
