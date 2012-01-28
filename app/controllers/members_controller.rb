class MembersController < ApplicationController
  def index
    @members = Member.order(:last_name)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.create(params[:member])

    if @member.valid?
      redirect_to members_path
    else
      render :new
    end
  end

  def destroy
    Member.destroy(params[:id])
    redirect_to members_path
  end
end
