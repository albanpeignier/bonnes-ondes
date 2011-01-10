# -*- coding: utf-8 -*-
class PagesController < ApplicationController

  # GET /pages
  # GET /pages.xml
  def index
    @show = find_show
    @pages = @show.pages

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = find_show.pages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = find_show.pages.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = find_show.pages.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = find_show.pages.build(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = "Votre information est ajoutée"
        format.html { redirect_to admin_show_page_path(@page.show, @page) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = find_show.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Votre information a été modifiée'
        format.html { redirect_to admin_show_page_path(@page.show, @page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    show = find_show
    show.pages.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(admin_show_pages_url(show)) }
      format.xml  { head :ok }
    end
  end

  def move_up
    show = find_show
    show.pages.find(params[:id]).move_higher

    respond_to do |format|
      format.html { redirect_to(admin_show_path(show)) }
      format.xml  { head :ok }
    end
  end

  private

  def find_show(show_id = params[:show_id])
    current_user.shows.find(show_id)
  end

end
