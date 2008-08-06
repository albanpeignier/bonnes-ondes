class SitemapsController < ApplicationController

  skip_before_filter :login_required

  def show
    @show = Show.find_by_slug(params[:id])
    render :layout => false
  end

end
