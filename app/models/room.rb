class Room < ApplicationRecord
  belongs_to :user 
  has_many :reservations

  validates :name, :detail, :address, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def self.search_by_address_and_detail(address_query, detail_query)
    address_words = address_query.split(' ')
    detail_words = detail_query.split(' ')
    result = Room.all
    address_words.each do |word|
      result = result.where('address LIKE ?', "%#{word}%")
    end
    detail_words.each do |word|
      result = result.where('detail LIKE ?', "%#{word}%")
    end
    result
  end

  mount_uploader :room_image, ImageUploader
end
