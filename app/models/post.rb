class Post < ActiveRecord::Base
  belongs_to :show
  validates_presence_of :show_id

  liquid_methods :title, :description

  named_scope :last_updated, :order => 'updated_at desc', :limit => 5
end
