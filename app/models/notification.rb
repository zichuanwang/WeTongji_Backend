class Notification < ActiveRecord::Base
  attr_accessible :description, :out_id, :title, :type, :user_id, :unread
  belongs_to: user
end
