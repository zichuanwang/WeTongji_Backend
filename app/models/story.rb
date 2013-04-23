class Story < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :is_pending, :visiable, :pending_reason
  has_many :story_comments, :counter_cache => true, :conditions => { :visiable => true }
  belongs_to :user
  has_attached_file :image
end
