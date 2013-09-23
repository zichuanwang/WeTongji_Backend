class AddTimeExecToApiLog < ActiveRecord::Migration
  def change
  	add_column :api_logs, :begin, :datetime
  	add_column :api_logs, :end, :datetime
  	add_column :api_logs, :duration, :integer
  end
end
