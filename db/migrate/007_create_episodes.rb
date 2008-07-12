class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.column :order, :integer
      t.column :title, :string, :null => false
      t.column :slug, :string, :null => false
      t.column :description, :string, :limit => 32000
      t.column :show_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :episodes
  end
end
