class Image < ActiveRecord::Base

  liquid_methods :width, :height

  belongs_to :show
  has_attachment :storage => :file_system, :max_size => 300.kilobytes, :content_type => :image, :thumbnails => { :normal => '200>', :thumb => '75' }
  validates_as_attachment

  protected

  def attachment_attributes_valid?
    if self.size > attachment_options[:max_size]
      errors.add :size, "Le fichier de l'image est trop grand (300 ko maximum)"
    elsif self.content_type != :image
      errors.add :size, "Le fichier n'est pas reconnu comme une image"
    else
      super
    end
  end

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
