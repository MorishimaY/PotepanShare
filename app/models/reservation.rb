class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :room, :person_num, :check_in, :check_out, presence: true
  validates :person_num, numericality: { greater_than_or_equal_to: 1 }
  validate :date_before_start
  validate :date_before_finish

  def date_before_start
    return if check_in.blank?
    errors.add(:check_in, "は本日以降のものを選択してください") if check_in < Date.today
  end

  def date_before_finish
    return if check_out.blank? || check_in.blank?
    errors.add(:check_out, "はチェックイン日以降のものを選択してください") if check_in < check_out
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
