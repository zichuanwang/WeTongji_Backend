class ResizeActivityBodyLength < ActiveRecord::Migration
  def up
  	change_column :activities, :description, :text
  	change_column :news, :context, :text
  end

  def down
  	change_column :activities, :description, :string
  	change_column :news, :context, :string
  end
end
