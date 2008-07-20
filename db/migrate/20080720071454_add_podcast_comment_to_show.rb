class AddPodcastCommentToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :podcast_comment, :string
  end

  def self.down
    remove_column :shows, :podcast_comment
  end
end
