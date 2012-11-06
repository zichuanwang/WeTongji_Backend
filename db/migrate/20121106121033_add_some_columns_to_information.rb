class AddSomeColumnsToInformation < ActiveRecord::Migration
  def change
    add_column :information, :source, :string
    add_column :information, :summary, :text
    add_column :information, :like, :integer
    add_column :information, :favorite, :integer
    remove_column :information, :image

    create_table :information_users_favorites do |t|
		t.integer :user_id
      	t.integer :information_id
    end

    create_table :information_users_likes do |t|
      	t.integer :user_id
      	t.integer :information_id
    end
    
  end
end
