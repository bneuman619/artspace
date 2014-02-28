class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :renter_id
      t.references :space
      t.datetime :start_time
      t.datetime :end_time
      t.integer :num_people
      t.text :intended_use

      t.timestamps
    end

    add_index :reservations, :renter_id
    add_index :reservations, :space_id
  end
end
