class CreateCocoaTemplate < ActiveRecord::Migration
  def self.up
    Template.create :name => "Cocoa", :slug => "cocoa"
  end

  def self.down
    Template.find_by_slug("cocoa").destroy
  end
end
