# -*- coding: utf-8 -*-
class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @show = find_show
    @posts = @show.posts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = find_show.posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = find_show.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = find_show.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = find_show.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = "Votre information est ajoutée"
        format.html { redirect_to admin_show_post_path(@post.show, @post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = find_show.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Votre information a été modifiée'
        format.html { redirect_to admin_show_post_path(@post.show, @post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    show = find_show
    show.posts.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(admin_show_posts_url(show)) }
      format.xml  { head :ok }
    end
  end

  private

  def find_show(show_id = params[:show_id])
    current_user.shows.find(show_id)
  end

end
