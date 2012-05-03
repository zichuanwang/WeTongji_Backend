class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :no
      t.string :password
      t.string :password_salt
      t.string :uid
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.string :email
      t.string :display_name

      t.timestamps
    end
  end
end
