class RemoveBasicTemplate < ActiveRecord::Migration
  def self.up
    template=Template.find_by_slug('basic')
    template.destroy unless template.nil?
  end

  def self.down
    Template.create :name => "Basic", :slug => "basic"
  end
end
