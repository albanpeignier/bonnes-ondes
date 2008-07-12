class AddTimestamps < ActiveRecord::Migration

  def self.up
    [ Show, Episode ].each do |c|
      table = c.table_name

      add_column table, :created_at, :timestamp
      add_column table, :updated_at, :timestamp

      c.reset_column_information

      c.update_all(["created_at = ?", Time.now])
      c.update_all(["updated_at = ?", Time.now])
    end
  end

  def self.down
    [ :shows, :episodes ].each do |table|
      remove_column table, :created_at
      remove_column table, :updated_at
    end
  end

end
