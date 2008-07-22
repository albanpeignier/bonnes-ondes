class PublicController < ApplicationController

  layout "public"
  skip_before_filter :login_required

  before_filter :assigns_show

  def welcome
    if @show.blank?
      if request.host =~ /((www.)bonnes-ondes.fr|localhost)/
        @episodes_last =  Episode.find(:all, :order => "created_at DESC", :limit => 10)
      else
        raise ActiveRecord::RecordNotFound
      end
    else
      render_show
    end
  end

  def show
    render_show
  end

  def episode
    @episode = find_episode
    render :layout => "public_render"
  end

  def feed
    render :content_type => "application/rss+xml", :layout => false
  end

  def playlist
    content_playlist find_content
  end

  def content
    @content = find_content
    @page_type = :condensed
    render :layout => "public_render"
  end

  private

  def render_show
    create_visit @show
    render :layout => "public_render", :action => :show
  end

  def assigns_show
    host = Host.find_by_name(request.host)
    unless host.blank?
      @show = host.show
    end

    show_slug = ""
    if request.host =~ /^(.*).bonnes-ondes.fr$/
      show_slug = $1
    end

    @show = find_show(show_slug)
  end

  def find_show(slug = nil)
    @show ||= Show.find_by_slug(slug)
  end

  def find_episode
    find_show.episodes.find_by_slug(params[:episode_slug])
  end

  def find_content
    find_episode.contents.find_by_slug(params[:content_slug])
  end

  def create_visit(show)
    return if logged_in? and current_user.shows.include? show
    return unless request.env["HTTP_USER_AGENT"].match(/MSIE|Gecko|Mozilla|Opera|KTML/)

    show.increment! :visit_count
  end

end
