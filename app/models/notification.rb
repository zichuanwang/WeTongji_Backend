class Notification < ActiveRecord::Base
  attr_accessible :description, :out_id, :title, :out_model_name, :user_id, :unread, :rejected_at
  belongs_to :user
end
