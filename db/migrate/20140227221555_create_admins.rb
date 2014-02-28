class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :administrator_id
      t.references :space

      t.timestamps
    end

    add_index :admins, :administrator_id
    add_index :admins, :space_id
  end
end
