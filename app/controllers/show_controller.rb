class ShowController < ApplicationController

  def create
    if request.post?
      @show = current_user.shows.build(params[:show])
      if @current_user.save
        flash[:notice] = "Votre émission est créé"
        redirect_to :action => "show", :id => @show
      else
        flash[:error] = "Impossible de créer l'émission"
      end
    else
      @show = Show.new(params[:show])
    end
  end

  def create_slug
    @slug = Slug.slugify(params[:name])
  end

  def show
    @show = current_user.shows.find(params[:id])
  end

  def edit
    @show = current_user.shows.find(params[:id])
    return unless request.post?

    if @show.update_attributes(params[:show])
      flash[:notice] = "Votre émission est modifiée"
      redirect_to :action => "show", :id => @show
    else
      flash[:error] = "Impossible de modifier l'émission"
    end
  end

  def delete
    current_user.shows.find(params[:id]).destroy
    redirect_to :controller => "account", :action => "index"
  end

  def select_logo
    @show = current_user.shows.find(params[:id])
    return unless request.post?

    if @show.update_attributes(params[:show])
      flash[:notice] = "Le logo est modifié"
      redirect_to :action => "show", :id => @show
    else
      flash[:error] = "Impossible de modifier le logo"
    end
  end

end
