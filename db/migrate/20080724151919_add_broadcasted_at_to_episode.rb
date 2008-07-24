class AddBroadcastedAtToEpisode < ActiveRecord::Migration
  def self.up
    add_column :episodes, :broadcasted_at, :datetime
  end

  def self.down
    remove_column :episodes, :broadcasted_at
  end
end
