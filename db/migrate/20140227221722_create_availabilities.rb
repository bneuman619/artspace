class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :space
      t.datetime :start_time
      t.datetime :end_time
      t.integer :day

      t.timestamps
    end

    add_index :availabilities, :space_id
  end
end
