class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.references :user
      t.references :space

      t.timestamps
    end
  end
end
