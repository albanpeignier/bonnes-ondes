class PublicController < ApplicationController

  layout "public"
  skip_before_filter :login_required

  before_filter :assigns_show

  def welcome
    @episodes_last =  Episode.find(:all, :order => "created_at DESC", :limit => 10)
  end

  def show
    create_visit @show
    render :layout => "public_render"
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

  def assigns_show
    @show = find_show unless params[:show_slug].blank?
  end

  def find_show
    return @show unless @show.blank?

    show = Show.find_by_slug(params[:show_slug])
    raise ActiveRecord::RecordNotFound if show.nil?
    show
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
