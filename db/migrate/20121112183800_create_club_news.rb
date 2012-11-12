class CreateClubNews < ActiveRecord::Migration
  def change
    create_table :club_news do |t|
      t.string :title
      t.string :source
      t.string :summary
      t.string :context
      t.integer :read
      t.integer :like
      t.integer :favorite
      t.integer :admin_id

      t.timestamps
    end
  end
end
