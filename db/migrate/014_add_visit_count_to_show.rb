class AddVisitCountToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :visit_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :shows, :visit_count
  end
end
