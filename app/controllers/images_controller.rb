# -*- coding: utf-8 -*-
class ImagesController < ApplicationController

  def index
    @show = find_show
    @images = @show.images.paginate(:per_page => 10, :page => (params[:page] or 1), :order => 'created_at desc')
  end

  def show
    @image = find_show.images.find(params[:id])
  end

  def new
    @image = find_show.images.build
  end

  def create
    @image = find_show.images.build(params[:image])

    if @image.save
      flash[:notice] = "L'image est ajoutée"
      redirect_to admin_show_images_path(@image.show)
    else
      flash[:error] = "Impossible de créer l'image"
      logger.debug @image.errors.inspect
      render :action => 'new'
    end
  end

  def destroy
    image = find_show.images.find(params[:id])

    image.destroy
    flash[:notice] = "L'image est supprimée"
    redirect_to admin_show_images_path(image.show)
  end

  protected

  def find_show
    current_user.shows.find(params[:show_id])
  end

end
