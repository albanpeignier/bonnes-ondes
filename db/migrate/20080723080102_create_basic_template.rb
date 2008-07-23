class CreateBasicTemplate < ActiveRecord::Migration
  def self.up
    Template.create :name => "Basic", :slug => "basic"
  end

  def self.down
    Template.find_by_slug("basic").destroy
  end
end
