class Template < ActiveRecord::Base

  liquid_methods :slug

end

class Template::LiquidDropClass

  def url_for_assets
    "/templates/#{@object.slug}"
  end

  def admin_link_tag
    account_link = if view.logged_in?
      view.link_to("Mon compte", :controller => "account", :action => "index")
    else
      view.link_to("S'identifier", :controller => "account", :action => "login")
    end

    "#{account_link} - hébergé par <a href='http://www.bonnes-ondes.fr'>Bonnes Ondes</a>"
  end

end
