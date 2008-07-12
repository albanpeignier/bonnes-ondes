class ContentController < ApplicationController

  def create_audiobank
    create(:audiobank)
  end

  def create_net
    create(:net)
  end

  def play
    content = current_user.find_content(params[:id])
    content_playlist content
  end

  def delete
    content = current_user.find_content(params[:id])
    episode = content.episode
    content.destroy
    redirect_to :controller => "episode", :action => "show", :id => episode
  end

  private

  def create(type)
    episode_id = request.post? ? params[:content][:episode_id] : params[:episode_id]
    episode = current_user.find_episode(episode_id)
    first_content = episode.contents.empty?

    @content = Content.create(type, params[:content])
    @content.episode = episode

    if first_content
      @content.name = "Intégrale"
      @content.slug = Slug.slugify(@content.name)
    end

    if request.post?
      if @content.save
        flash[:notice] = "Le contenu est ajouté"
        redirect_to :controller => "episode", :action => "show", :id => episode
      else
        flash[:error] = "Impossible d'ajouter le contenu"
      end
    end
  end


end
