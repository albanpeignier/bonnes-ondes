class Image < ActiveRecord::Base

  liquid_methods :width, :height

  belongs_to :show
  has_attachment :storage => :file_system, :max_size => 300.kilobytes, :content_type => :image, :thumbnails => { :normal => '200>', :thumb => '75' }
  validates_as_attachment
end

class Image::LiquidDropClass
  def url_for
    view.image_path @object.public_filename(:normal)
  end

  def url_for_thumb
    view.image_path @object.public_filename(:thumb)
  end

  def tag
    view.image_tag(@object.public_filename(:normal), :title => @object.title)
  end

  def tag_for_thumb
    view.image_tag(@object.public_filename(:thumb), :title => @object.title)
  end
end
