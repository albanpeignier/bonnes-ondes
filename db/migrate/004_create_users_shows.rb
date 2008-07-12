class CreateUsersShows < ActiveRecord::Migration
  def self.up
    create_table :shows_users, :id => false do |t|
      t.column :show_id, :int, :null => false
      t.column :user_id, :int, :null => false
    end
  end

  def self.down
    drop_table :shows_users
  end
end
