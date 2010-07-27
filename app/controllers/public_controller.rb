# -*- coding: utf-8 -*-
class PublicController < ApplicationController

  layout "public"
  skip_before_filter :login_required

  append_view_path "#{Rails.root}/templates"

  before_filter :assigns_show, :create_user_google_analytics_account, :except => [:feed, :robots, :welcome]
  before_filter :assigns_now

  rescue_from ActiveRecord::RecordNotFound, :with => :show_home_page_when_not_found

  def welcome
    begin
      load_show
      render_show
    rescue ActiveRecord::RecordNotFound
      # localhost is used in development
      # www.example.com is used by cucumber
      if request.host =~ /www.bonnes-ondes\.fr|www.bonnes-ondes\.local|localhost|www.example.com/
        @episodes_last =  Episode.find :all, :order => "created_at DESC", :limit => 10
      else
        raise ActiveRecord::RecordNotFound
      end
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
    load_show [{:episodes => [ :show, { :contents => { :episode => [ :contents, :tags, { :show => :host } ] } }, :tags ]}, :host] 
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
    render_template current_show, :stream, current_show
  end

  def robots
    load_show [{:episodes => {:show => :host }}, {:contents => {:episode => {:show => :host}} }]
    respond_to do |format|
   	  format.txt { render :layout => false }
    end
  end

  def vote
    @episode = current_show.episodes.find(params[:episode_id])

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
    @episodes = Episode.sort(current_show.episodes.find_tagged_with(@search))

    respond_to do |format|
      format.html {
        render_template current_show, :search, @search
      }
      format.m3u {
        render :layout => false
        # render tags.m3u.erb
      }
    end
  end

  private

  def show_home_page_when_not_found
    logger.info "Page not found for #{request.host}#{request.path}"
    flash[:notice] = "La page demandée n'existe pas"
    unless request.path == "/"
      redirect_to "/"
    else
      redirect_to "http://www.bonnes-ondes.fr"
    end
  end

  def render_show
    create_visit current_show
    render_template current_show, :show, current_show
  end

  def render_template(show, view, object)
    template = show.template
    @theme = template
    render :layout => false, :template => "#{template.slug}/#{view}",
      :locals => { view.to_sym => object }
  end

  def assigns_now
    @now = Time.now
  end

  def create_user_google_analytics_account
    user_tracker_id = (current_show and current_show.host and current_show.host.google_analytics_tracker_id)

    unless user_tracker_id.blank?
      request.google_analytics_account = Rubaidh::GoogleAnalytics.new(user_tracker_id)
    end
  rescue ActiveRecord::RecordNotFound
    logger.debug "Can't find an associated Show for Goggle Analytics account"
  end

  def current_show(include = [])
    unless @show
      if host = Host.find_by_name(request.host)
        @show = Show.find(host.show, :include => include)
      else
        if request.host =~ /^(.*).bonnes-ondes.(fr|local)$/
          @show = Show.find_by_slug($1, :include => include)
        end
      end

      raise ActiveRecord::RecordNotFound unless @show
    end

    @show
  end
  alias_method :load_show, :current_show
  alias_method :assigns_show, :current_show

  def find_episode
    current_show.episodes.find_by_slug(params[:episode_slug]) or raise ActiveRecord::RecordNotFound
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
