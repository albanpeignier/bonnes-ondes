class CreateTemplatesUsers < ActiveRecord::Migration
  def self.up
    create_table "templates_users", :id => false do |t|
      t.integer :template_id, :null => false
      t.integer :user_id, :null => false
    end
  end

  def self.down
    drop_table :templates_users
  end
end
