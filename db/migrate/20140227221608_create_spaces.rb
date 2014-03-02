class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.integer :creator_id
      t.string :title
      t.text :description
      t.string :dimensions
      t.text :ammenities
      t.integer :rate
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :email
      t.string :phone

      t.timestamps
    end

    add_index :spaces, :creator_id
  end
end
