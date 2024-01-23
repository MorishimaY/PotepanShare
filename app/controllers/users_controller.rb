class UsersController < ApplicationController
  def index
    @user = current_user
    @room = Room.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
  end

end