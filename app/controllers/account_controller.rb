# -*- coding: utf-8 -*-
class AccountController < ApplicationController

  skip_before_filter :login_required

  # say something nice, you goof!  something sweet.
  def index
    unless logged_in?
      redirect_to(:action => 'login')
      return
    end

    @user = self.current_user

    @show_count = @user.shows.size
    @show_lasts = @user.shows.find(:all, :order => "updated_at desc", :limit => 3)

    @episodes_count = @user.episodes.size
    @episodes_lasts = @user.episodes.sort_by { |e| e.created_at }.first(5).reverse
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => 'account', :action => 'index')
      flash[:notice] = "Bienvenue sur votre compte"
    else
      flash[:failure] = "Mauvais login ou mot de passe"
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => 'account', :action => 'index')
    flash[:notice] = "Votre compte est créé. Vous allez recevoir un email pour l'activer."
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end

  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Vous n'êtes plus connecté"
    redirect_to(:controller => 'public', :action => 'welcome')
  end

  def recover_password
    @email = params[:email]

    if request.post?
      user = User.find_by_email(@email)
      unless user.nil?
        user.change_password
        user.save!
        flash[:success] = "Votre nouveau de passe a été envoyé à #{user.email}"
        redirect_to :action => :login
      else
        flash[:failure] = "Aucun compte Bonnes-Ondes ne correspond à cet email"
      end
    end
  end

  def activate
    if params[:code]
      @user = User.find_by_activation_code(params[:code])
      if @user and @user.activate
        flash[:notice] = "Votre compte a été activé"
      else
        flash[:error] = "Impossible d'activer votre compte."
      end
    else
      flash.clear
    end

    redirect_back_or_default(:controller => 'account', :action => 'index')
  end
end
