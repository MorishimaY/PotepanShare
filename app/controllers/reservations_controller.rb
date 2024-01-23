class ReservationsController < ApplicationController
  
  def index
    @rooms = Room.all
    @reservations = current_user.reservations
    @user = current_user
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(params.require(:reservation).permit(:user_id, :room_id, :person_num, :sum_price, :check_in, :check_out))
    if @reservation.save
      flash[:notice] = "予約を完了しました"
      redirect_to reservations_path
    else
      Rails.logger.debug(@reservation.errors.full_messages)
      render "rooms/show"
    end
  end

  def show
    @rooms = Room.joins(:reservations).where(reservations: { user_id: current_user.id })
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    
    if @reservation.person_num.present? && @reservation.total_days.present?
      @sum_price = @room.price * @reservation.person_num * @reservation.total_days
    else
      @sum_price = 0
    end

    if @check_in.present? && @check_out.present?
      @total_days = (@reservation.check_out - @reservation.check_in).to_i
    else
      @total_days = 0
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:notice] = "予約が更新されました"
      redirect_to reservations_path
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約が削除されました"
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :person_num, :room_id)
  end
end