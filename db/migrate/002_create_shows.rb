class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.column :name, :string
      t.column :description, :string
    end
  end

  def self.down
    drop_table :shows
  end
end
