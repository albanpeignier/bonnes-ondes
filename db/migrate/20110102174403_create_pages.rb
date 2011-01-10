class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.integer :parent_id
      t.integer :show_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
