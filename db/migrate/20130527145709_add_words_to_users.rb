class AddWordsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :words, :string
  end
end
