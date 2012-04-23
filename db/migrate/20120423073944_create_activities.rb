class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :begin
      t.datetime :end
      t.string :title
      t.string :location
      t.integer :follow
      t.string :organizer
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
