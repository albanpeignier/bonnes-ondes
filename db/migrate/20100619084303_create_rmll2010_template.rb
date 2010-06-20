class CreateRmll2010Template < ActiveRecord::Migration
  def self.up
    Template.create :name => "Radio RMLL 2010", :slug => "rmll2010"
  end

  def self.down
    Template.find_by_slug('rmll2010').destroy
  end
end
