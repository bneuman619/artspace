class CreateStripes < ActiveRecord::Migration
  def change
    create_table :stripes do |t|

      t.timestamps
    end
  end
end
