class ImageController < ApplicationController

  def list
    @images = current_user.shows.find(params[:show]).images
  end

  def create
    show_id = request.post? ? params[:image][:show_id] : params[:show]
    show = current_user.shows.find(show_id)

    @image = show.images.build(params[:image])

    if request.post?
      if @image.save
        flash[:notice] = "L'image est ajoutée"
        redirect_to :controller => "show", :action => "show", :id => @image.show
      else
        flash[:error] = "Impossible de créer l'image"
      end
    end
  end

  def delete

  end

end
