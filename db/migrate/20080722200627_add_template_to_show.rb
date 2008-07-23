class AddTemplateToShow < ActiveRecord::Migration
  def self.up
    change_table :shows do |t|
      t.belongs_to :template
    end
  end

  def self.down
    change_table :shows do |t|
      t.remove_belongs_to :template
    end
  end
end
