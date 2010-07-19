module ShowHelper

  def admin_show_path(show)
    url_for :controller => "/show", :action => "show", :id => show
  end
  
  def link_to_admin_show(show)
    link_to show.name, admin_show_path(show)
  end

end
