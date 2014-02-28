class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :space
      t.time :start_time
      t.time :end_time
      t.integer :day

      t.timestamps
    end

    add_index :availabilities, :space_id
  end
end
