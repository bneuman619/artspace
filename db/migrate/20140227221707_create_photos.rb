class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :space
      t.string :title
      t.string :url
      t.string :short_description
      t.boolean :primary

      t.timestamps
    end
  end
end
