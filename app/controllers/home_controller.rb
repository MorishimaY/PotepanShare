class HomeController < ApplicationController
  def top
    @user = current_user
  end

  def search
    if params[:address].present?
      @rooms = Room.where('address LIKE ?', "%#{params[:address]}%")
      redirect_to rooms_search_path
    else
      @rooms = Room.none
    end
  end

end
