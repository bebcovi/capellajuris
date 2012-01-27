# encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    if admin[:username] == params[:username] and admin[:password] == params[:password]
      log_in
      redirect_to home_path
    else
      @error = "Pogrešno korisničko ime ili lozinka"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to home_path
  end

private

  def log_in
    session[:admin_logged_in?] = true
  end

  def log_out
    session.delete(:admin_logged_in?)
  end
end
