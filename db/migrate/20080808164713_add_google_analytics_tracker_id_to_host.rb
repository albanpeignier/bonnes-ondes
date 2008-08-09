class AddGoogleAnalyticsTrackerIdToHost < ActiveRecord::Migration
  def self.up
    add_column :hosts, :google_analytics_tracker_id, :string
  end

  def self.down
    remove_column :hosts, :google_analytics_tracker_id
  end
end
