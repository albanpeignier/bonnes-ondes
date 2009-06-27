class CreateRe2009Template < ActiveRecord::Migration
  def self.up
    Template.create :name => "Radio Esperanzah! 2009", :slug => "re2009"
  end

  def self.down
    Template.find_by_slug('re2009').destroy
  end
end
