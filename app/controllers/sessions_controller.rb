# encoding: utf-8
class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    unless user_already_registered?
      @user.register!
      if @user.valid?
        log_in(@user)
        redirect_to home_path
      else
        render :new
      end
    else
      if authenticated_user = User.authenticate(params[:user])
        log_in(authenticated_user)
        redirect_to home_path
      else
        @error = "Pogrešno korisničko ime ili lozinka"
        render :new
      end
    end
  end

  def destroy
    log_out
    redirect_to home_path
  end

private

  def user_already_registered?
    User.any?
  end
  helper_method :user_already_registered?

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end
end
