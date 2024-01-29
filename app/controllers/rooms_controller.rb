class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def own
    @rooms = Room.where(user_id: current_user.id)
    @user = current_user
  end

  def new
    @user = current_user
    @room = Room.new
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :detail, :price, :address, :room_image, :room_image_cache))
    @room.user = current_user
    if @room.save
      flash[:notice] = "施設を新規登録しました"
      redirect_to :rooms_own
    else
      @rooms = Room.all
      render "rooms/new"
    end
  end

  def show
    @reservation = Reservation.new
    @room = Room.find_by(id: params[:id])
    if @room.nil?
      redirect_to root_path, alert: "Room not found"
    end
    @user = User.find(current_user.id)
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

  def search
    if params[:address_query].present? || params[:detail_query].present?
      @rooms = Room.search_by_address_and_detail(params[:address_query], params[:detail_query])
    else
      @rooms = Room.none
    end
    render :search_results
  end

end