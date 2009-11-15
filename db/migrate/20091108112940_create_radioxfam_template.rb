class CreateRadioxfamTemplate < ActiveRecord::Migration
  def self.up
    Template.create :name => "Radio Oxfam", :slug => "radioxfam"
  end

  def self.down
    Template.find_by_slug('radioxfam').destroy
  end
end
