class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def own
    @rooms = Room.all
  end

  def new
    @user = current_user
    @room = Room.new
  end

  def create
    @room = Room.create!(params.require(:room).permit(:name, :detail, :price, :address, :room_image))
      if @room.save
        flash[:notice] = "施設を新規登録しました"
        render :new_room
      else
        @rooms = Room.all
        render "rooms/new"
      end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
