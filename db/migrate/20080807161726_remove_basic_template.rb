class RemoveBasicTemplate < ActiveRecord::Migration
  def self.up
    Template.find_by_slug("basic").destroy
  end

  def self.down
    Template.create :name => "Basic", :slug => "basic"
  end
end
