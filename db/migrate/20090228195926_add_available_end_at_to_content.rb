class AddAvailableEndAtToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :available_end_at, :datetime
  end

  def self.down
    remove_column :contents, :available_end_at
  end
end
