class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.integer :out_id
      t.string :out_model_name
      t.integer :user_id

      t.timestamps
    end
  end
end
