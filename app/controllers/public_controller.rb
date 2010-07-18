# -*- coding: utf-8 -*-
class PublicController < ApplicationController

  layout "public"
  skip_before_filter :login_required

  append_view_path "#{Rails.root}/templates"

  before_filter :assigns_show, :assigns_now, :create_user_google_analytics_account

  rescue_from ActiveRecord::RecordNotFound, :with => :show_home_page_when_not_found

  def welcome
    if @show.blank?
      # localhost is used in development
      # www.example.com is used by cucumber
      if request.host =~ /(www.)bonnes-ondes\.fr|bonnes-ondes\.local|localhost|www.example.com/
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
    render_template @episode.show, :episode, @episode
  end

  def feed
    render :content_type => "application/rss+xml", :layout => false
  end

  def playlist
    content_playlist find_content
  end

  def content
    @content = find_content
    render_template @content.episode.show, :content, @content
  end

  def direct
    render_template @show, :stream, @show
  end

  def robots
    respond_to do |format|
   	  format.txt { render :layout => false }
    end
  end

  def vote
    @episode = @show.episodes.find(params[:episode_id])

    if request.post? and user_session.can_rate_episode?(@episode)
      @episode.rate params[:rating].to_i
      user_session.rate_episode(@episode)
    end

    respond_to do |format|
   	  format.html { redirect_to :action => "episode", :episode_slug => @episode.slug }
   	  format.js { render :layout => false }
   	end
  end

  def tags
    @search = params[:search]
    @episodes = Episode.sort(@show.episodes.find_tagged_with(@search))

    respond_to do |format|
      format.html {
        render_template @show, :search, @search
      }
      format.m3u {
        render :layout => false
        # render tags.m3u.erb
      }
    end
  end

  private

  def show_home_page_when_not_found
    flash[:notice] = "La page demandée n'existe pas"
    redirect_to "/"
  end

  def render_show
    create_visit @show
    render_template @show, :show, @show
  end

  def render_template(show, view, object)
    template = show.template
    @theme = template
    render :layout => false, :template => "#{template.slug}/#{view}",
      :locals => { view.to_sym => object }
  end

  def assigns_show
    host = Host.find_by_name(request.host)
    unless host.blank?
      @show = host.show
    end

    show_slug = ""
    if request.host =~ /^(.*).bonnes-ondes.(fr|local)$/
      show_slug = $1
    end

    @show = find_show(show_slug)
  end

  def assigns_now
    @now = Time.now
  end

  def create_user_google_analytics_account
    user_tracker_id = (@show and @show.host and @show.host.google_analytics_tracker_id)

    unless user_tracker_id.blank?
      request.google_analytics_account = Rubaidh::GoogleAnalytics.new(user_tracker_id)
    end
  end

  def find_show(slug = nil)
    @show ||= Show.find_by_slug(slug)
  end

  def find_episode
    find_show.episodes.find_by_slug(params[:episode_slug]) or raise ActiveRecord::RecordNotFound
  end

  def find_content
    find_episode.contents.find_by_slug(params[:content_slug]) or raise ActiveRecord::RecordNotFound
  end

  def create_visit(show)
    return if logged_in? and current_user.shows.include? show
    return unless (request.env["HTTP_USER_AGENT"] and request.env["HTTP_USER_AGENT"].match(/MSIE|Gecko|Mozilla|Opera|KTML/))

    show.increment! :visit_count
  end

end
