class Notification < ActiveRecord::Base
  attr_accessible :description, :out_id, :title, :out_model_name, :user_id, :unread
  belongs_to :user
end
