# encoding: utf-8
class MembersController < ApplicationController
  before_filter :authorize

  def gui
    @members = Member.order(:last_name)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.create(params[:member])

    if @member.valid?
      redirect_to edit_members_path, :notice => "\"#{@member}\" je uspješno dodan."
    else
      render :new
    end
  end

  def destroy
    member = Member.destroy(params[:id])
    redirect_to edit_members_path, :notice => "\"#{member}\" uspješno je izbrisan."
  end
end
