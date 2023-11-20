class UsersController < ApplicationController
  def index
    @user = current_user
    @room = Room.all
  end
  
  def show
    @user = current_user
  end

  def profile
    @user = current_user
  end


end
