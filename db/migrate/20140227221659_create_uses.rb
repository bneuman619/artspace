class CreateUses < ActiveRecord::Migration
  def change
    create_table :uses do |t|
      t.string :type

      t.timestamps
    end
  end
end
