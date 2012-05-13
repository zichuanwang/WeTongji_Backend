class Activity < ActiveRecord::Base
	belongs_to :channel
	belongs_to :organizer
	belongs_to :sub_organizer
	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "activities_users_favorites"
	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "activities_users_likes"

	validates_presence_of :organizer, :sub_organizer, :title, :begin, :end, :location, :description

	before_create :init_model

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

	def user_schedule(uid)
		if self.schedule < 0
			self.schedule = 0
		end
		self.schedule = self.schedule + 1
		# add to schedule
	end

	def user_unschedule(uid)
		if self.schedule > 0
			self.schedule = self.schedule - 1
		end

		# remove from schedule
	end

	def can_favorite(user)
		!self.users_favorites.exists?(user)
	end

	def can_like(user)
		!self.users_likes.exists?(user)
	end

	def can_schedule(uid)
		true
	end

	private
	def init_model
		self.favorite = 0
		self.like = 0
		self.schedule = 0
	end
end
