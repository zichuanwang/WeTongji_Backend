class AddFeedbackToStory < ActiveRecord::Migration
  def change
    add_column :stories, :for_admin, :boolean, :default => false
    add_column :stories, :report_count, :integer, :default => 0
  end
end
