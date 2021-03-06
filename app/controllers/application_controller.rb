# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotification::Notifiable

  helper :all
  helper_method :admin_show_path


  before_filter :login_from_cookie, :login_required

  layout "default"

  helper_method :user_session

  def content_playlist(content)
    if content.respond_to? "playlist_url"
      redirect_to content.playlist_url
    else
      render :text => content.content_url, :content_type => "audio/x-mpegurl"
    end
  end
  
  protected

  def admin_show_path(show)
    url_for :controller => "/show", :action => "show", :id => show
  end

  private

  def user_session
    @user_session ||= UserSession.new(session)
  end

end
