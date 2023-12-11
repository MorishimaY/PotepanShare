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
        redirect_to :rooms_own
      else
        @rooms = Room.all
        render "rooms/new"
      end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
     if @room.update(params.require(:room).permit(:name, :detail, :price, :address, :room_image))
       flash[:notice] = "roomIDが「#{@room.id}」の情報を更新しました"
       redirect_to :rooms_own
     else
       render "edit"
     end

  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
      flash[:notice] = "登録済みのお部屋を削除しました"
      redirect_to :rooms_own
  end

end
