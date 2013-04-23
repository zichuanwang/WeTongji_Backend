class Story < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :is_pending, :visiable, :pending_reason
  has_many :story_comments, :counter_cache => true
  belongs_to :user
end
