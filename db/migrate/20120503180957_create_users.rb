class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :no
      t.string :encrypted_password
      t.string :password_salt
      t.string :uid
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.string :email
      t.string :display_name
      t.string :phone
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.datetime :last_seen_at
      t.integer :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.string :authentication_token

      t.timestamps
    end
  end
end
