class CreateZindemsTemplate < ActiveRecord::Migration
  def self.up
    Template.create :name => "Z'Indems'", :slug => "zindems"
  end

  def self.down
    Template.find_by_slug('zindems').destroy
  end
end
