# encoding: utf-8
class Activity < ActiveRecord::Base
	belongs_to :channel
	belongs_to :admin, :counter_cache => true
	belongs_to :organizer

	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "user_favorites", :foreign_key => "out_id", :conditions => "user_favorites.out_model_name = 'Activity'"
	has_and_belongs_to_many :user_likes, :class_name => "User", :join_table => "user_likes", :foreign_key => "out_id", :conditions => "user_likes.out_model_name = 'Activity'"

	has_and_belongs_to_many :users_schedules, :class_name => "User", :join_table => "activities_users_schedules"

	validates_presence_of :title, :begin, :end, :location, :description
	paginates_per 20
	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_create :init_model

	def delete
		self.users_favorites.clear
		self.users_likes.clear
		self.users_schedules.clear
		self.destroy
	end


	def user_schedule(user)
		if self.schedule < 0
			self.schedule = 0
		end
		
		if user && !self.users_schedules.exists?(user)
			self.users_schedules << user
			self.schedule += 1
		end
	end

	def user_unschedule(user)
		# remove from user favorite
		if user && self.users_schedules.exists?(user)
			self.users_schedules.delete(user)
			self.schedule -= 1
		end

		if self.schedule < 0
			self.schedule = 0
		end
	end


	def can_schedule(user)
		!self.users_schedules.exists?(user)
	end

	def check
		self.is_pending = Sensitive.check("#{self.title} #{self.description}")
		self.visiable = !self.is_pending
		if self.is_pending
			self.pending_reason = "含有不合适内容.等待管理员审核."
		end
	end

	private
	def init_model
		self.favorite = 0
		self.like = 0
		self.schedule = 0
	end

end
