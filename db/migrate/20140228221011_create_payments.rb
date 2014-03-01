class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :creator_id
      t.string :secret_api_key
      t.string :publishable_api_key
      t.string :refresh_token
      t.string :stripe_user_id

      t.timestamps
    end
    add_index :payments, :creator_id
  end
end
