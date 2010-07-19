class AddScmUrlToTemplate < ActiveRecord::Migration
  def self.up
    add_column :templates, :scm_url, :string
  end

  def self.down
    remove_column :templates, :scm_url
  end
end
