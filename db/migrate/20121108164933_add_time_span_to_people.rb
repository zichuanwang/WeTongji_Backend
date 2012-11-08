class AddTimeSpanToPeople < ActiveRecord::Migration
  def change
  	add_column :people, :no, :integer
  	add_column :people, :avatar_file_name, :string
  	add_column :people, :avatar_content_type, :string
  	add_column :people, :avatar_file_size, :integer
  	add_column :people, :avatar_updated_at, :datetime
  end
end
