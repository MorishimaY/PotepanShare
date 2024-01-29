class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :person_num
      t.integer :sum_price
      t.date :check_in
      t.date :check_out

      t.timestamps
    end
  end
end
