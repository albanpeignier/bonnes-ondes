class Post < ActiveRecord::Base
  belongs_to :show
  validates_presence_of :show_id

  liquid_methods :title, :description
end
