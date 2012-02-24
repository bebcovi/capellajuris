# encoding: utf-8
class SessionsController < ApplicationController
  before_filter :store_referer, :only => [:new, :destroy]

  def new
  end

  def create
    if admin.username == params[:username] and admin.password == params[:password]
      log_in
      redirect_to referer, :notice => "Uspješno ste se prijavili."
    else
      flash.now[:error] = "Pogrešno korisničko ime ili lozinka."
      render :new
    end
  end

  def destroy
    log_out
    redirect_to referer
  end

private

  def log_in
    session[:admin] = true
  end

  def log_out
    session.delete(:admin)
  end
end
