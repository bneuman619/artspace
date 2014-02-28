class CreateUses < ActiveRecord::Migration
  def change
    create_table :uses do |t|
      t.string :category

      t.timestamps
    end
  end
end
