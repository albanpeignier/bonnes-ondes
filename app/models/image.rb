class Image < ActiveRecord::Base
  belongs_to :show
  acts_as_attachment :storage => :file_system, :max_size => 300.kilobytes, :content_type => :image, :thumbnails => { :normal => '200>', :thumb => '75' }
  validates_as_attachment
end
