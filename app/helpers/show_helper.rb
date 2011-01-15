module ShowHelper

  def link_to_admin_show(show)
    link_to show.name, admin_show_path(show)
  end

end
