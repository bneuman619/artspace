class CreateStripes < ActiveRecord::Migration
  def change
    create_table :stripes do |t|
      t.integer :creator_id
      t.string :secret_api_key
      t.string :publishable_api_key
      t.string :refresh_token
      t.string :stripe_user_id

      t.timestamps
    end

    add_index :stripes, :creator_id
  end
end
