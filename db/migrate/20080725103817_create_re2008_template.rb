class CreateRe2008Template < ActiveRecord::Migration
  def self.up
    Template.create :name => "Esperanzah! 2008", :slug => "re2008"
  end

  def self.down
    Template.find_by_slug('re2008').destroy
  end
end
