class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :job_title
      t.string :words
      t.string :title
      t.text :description
      t.integer :read
      t.integer :like
      t.integer :favorite

      t.timestamps
    end
    create_table :people_users_favorites do |t|
      t.integer :user_id
        t.integer :person_id
    end

    create_table :people_users_likes do |t|
        t.integer :user_id
        t.integer :person_id
    end
  end
end
