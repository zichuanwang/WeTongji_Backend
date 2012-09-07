class CreateSensitives < ActiveRecord::Migration
  def change
    create_table :sensitives do |t|
      t.string :word

      t.timestamps
    end
  end
end
