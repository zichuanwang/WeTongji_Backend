class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.integer :follow
      t.string :description

      t.timestamps
    end
  end
end
