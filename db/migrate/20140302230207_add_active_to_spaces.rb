class AddActiveToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :active, :integer, default: 1
    add_index :spaces, :active
  end
end
