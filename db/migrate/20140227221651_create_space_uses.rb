class CreateSpaceUses < ActiveRecord::Migration
  def change
    create_table :space_uses do |t|
      t.references :use
      t.references :space
      t.boolean :primary

      t.timestamps
    end
  end
end
