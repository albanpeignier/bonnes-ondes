class CreateRmll2009Template < ActiveRecord::Migration
  def self.up
    Template.create :name => "Radio RMLL 2009", :slug => "rmll2009"
  end

  def self.down
    Template.find_by_slug('rmll2009').destroy
  end
end
