class StoryComment < ActiveRecord::Base
  attr_accessible :body, :user_id, :is_pending, :visiable, :pending_reason
  belongs_to :user
end
