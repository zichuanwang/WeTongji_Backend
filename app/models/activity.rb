class Activity < ActiveRecord::Base
	belongs_to :channel
	belongs_to :organizer
	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "activities_users_favorites"
	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "activities_users_likes"
	has_and_belongs_to_many :users_schedules, :class_name => "User", :join_table => "activities_users_schedules"

	validates_presence_of :organizer, :title, :begin, :end, :location, :description
	paginates_per 10

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_create :init_model

	def delete
		self.users_favorites.clear
		self.users_likes.clear
		self.users_schedules.clear
		self.destroy
	end

	def user_favorite(user)
		if self.favorite < 0
			self.favorite = 0
		end
		
		if user && !self.users_favorites.exists?(user)
			self.users_favorites << user
			self.favorite += 1
		end
	end

	def user_unfavorite(user)
		# remove from user favorite
		if user && self.users_favorites.exists?(user)
			self.users_favorites.delete(user)
			self.favorite -= 1
		end

		if self.favorite < 0
			self.favorite = 0
		end
	end

	def user_like(user)
		if self.like < 0
			self.like = 0
		end
		# add to user like
		if user && !self.users_likes.exists?(user)
			self.users_likes << user
			self.like += 1
		end
	end

	def user_unlike(user)
		if user && self.users_likes.exists?(user)
			self.users_likes.delete(user)
			self.like -= 1
		end

		if self.like < 0
			self.like = 0
		end
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

	def can_favorite(user)
		!self.users_favorites.exists?(user)
	end

	def can_like(user)
		!self.users_likes.exists?(user)
	end

	def can_schedule(user)
		!self.users_schedules.exists?(user)
	end

	private
	def init_model
		self.favorite = 0
		self.like = 0
		self.schedule = 0
	end
end
