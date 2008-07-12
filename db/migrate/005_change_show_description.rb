class ChangeShowDescription < ActiveRecord::Migration
  def self.up
    change_column :shows, :description, :string, :limit => 32000
  end

  def self.down
    
  end
end
