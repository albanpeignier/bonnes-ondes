class AddRating < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.create_ratings_table :with_rater => false
    Episode.add_ratings_columns
  end

  def self.down
    Episode.remove_ratings_columns
    ActiveRecord::Base.drop_ratings_table
  end
end
