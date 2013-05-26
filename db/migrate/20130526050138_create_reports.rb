class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :out_id
      t.string :out_model_name
      t.integer :user_id
      t.string :reason

      t.timestamps
    end
  end
end
