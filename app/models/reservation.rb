class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :room, :person_num, :check_in, :check_out, presence: true
  validates :person_num, numericality: { greater_than_or_equal_to: 1 }
  validate :today_before_check_in
  validate :today_before_check_out
  validate :check_in_before_check_out

  def today_before_check_in
    return if check_in.blank?
    errors.add(:check_in, "は本日以降のものを選択してください") if check_in < Date.today
  end

  def today_before_check_out
    return if check_out.blank?
    errors.add(:check_out, "は本日以降のものを選択してください") if check_out < Date.today
  end

  def check_in_before_check_out
    return if check_out.blank? || check_in.blank?
    errors.add(:check_out, "はチェックイン日以降のものを選択してください") if check_out <= check_in
  end

  def total_days
    if check_in.present? && check_out.present?
      @total_days = (check_out - check_in).to_i
    else
      @total_days = 0
    end
  end

  def sum_price
    @sum_price = room.price * self.person_num * self.total_days
  end
  # mount_uploader :room_image, ImageUploader

end
