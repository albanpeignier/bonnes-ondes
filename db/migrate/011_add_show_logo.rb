class AddShowLogo < ActiveRecord::Migration
  def self.up
    add_column :shows, :logo_id, :integer
  end

  def self.down
    remove_column :shows, :logo_id
  end
end
