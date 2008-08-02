class EpisodeController < ApplicationController

  def create
    show_id = request.post? ? params[:episode][:show_id] : params[:show]
    show = current_user.shows.find(show_id)

    @episode = show.episodes.build(params[:episode])
    @episode.order ||= show.next_episode_order

    if request.post?
      if @episode.save
        flash[:notice] = "L'épisode est créé"
        redirect_to :action => "show", :id => @episode
      else
        flash[:error] = "Impossible de créer l'épisode"
      end
    end
  end

  def create_slug
    @slug = Slug.slugify(params[:name])
  end

  def show
    @episode = current_user.find_episode(params[:id])
  end

  def edit
    @episode = current_user.find_episode(params[:id])
    return unless request.post?

    if @episode.update_attributes(params[:episode])
      flash[:notice] = "Votre épisode est modifié"
      redirect_to :action => "show", :id => @episode
    else
      flash[:error] = "Impossible de modifier l'épisode"
    end
  end

  def list
    @show = current_user.shows.find(params[:show])
    @episodes = @show.episodes.paginate(:per_page => 10, :page => (params[:page] or 1))
  end

  def delete
    episode = current_user.find_episode(params[:id])
    show = episode.show
    episode.destroy
    redirect_to :controller => "show", :action => "show", :id => show
  end

  def select_image
    @episode = current_user.find_episode(params[:id])
    return unless request.post?

    if @episode.update_attributes(params[:episode])
      flash[:notice] = "L'image est modifié"
      redirect_to :action => "show", :id => @episode
    else
      flash[:error] = "Impossible de modifier l'image"
    end
  end


end
