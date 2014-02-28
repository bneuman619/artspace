class CreateSpaceUses < ActiveRecord::Migration
  def change
    create_table :space_uses do |t|
      t.references :use
      t.references :space
      t.boolean :primary

      t.timestamps
    end

    add_index :space_uses, :use_id
    add_index :space_uses, :space_id
  end
end
