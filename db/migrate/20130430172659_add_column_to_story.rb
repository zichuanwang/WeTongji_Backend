class AddColumnToStory < ActiveRecord::Migration
  def change
  	add_column :stories, :is_anonymous, :boolean, :default => false
  	add_column :story_comments, :is_anonymous, :boolean, :default => false
  end
end
