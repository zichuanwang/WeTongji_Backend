class CreateApiLogs < ActiveRecord::Migration
  def change
    create_table :api_logs do |t|
      t.string :v
      t.string :d
      t.string :m
      t.string :u

      t.timestamps
    end
  end
end
