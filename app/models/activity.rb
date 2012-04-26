class Activity < ActiveRecord::Base
	belongs_to :channel
	belongs_to :organizer
	belongs_to :sub_organizer
	has_and_belongs_to_many :users

	validates_presence_of :organizer, :sub_organizer, :title, :begin, :end, :location, :description

	before_create :init_model

	def user_follow(uid)
		if self.follow < 0
			self.follow = 0
		end
		
		# add to user favorite
		user = User.find_by_uid(uid)
		if user && !self.users.exists?(user)
			self.users << user
			self.follow = self.follow + 1
		end
	end

	def user_unfollow(uid)
		# remove from user favorite
		user = User.find_by_uid(uid)
		if user && self.users.exists?(user)
			self.users.delete(user)
			self.follow = self.follow - 1
		end

		if self.follow < 0
			self.follow = 0
		end
	end

	def user_like(uid)
		if self.like < 0
			self.like = 0
		end
		self.like = self.like + 1
		# add relationship
	end

	def user_unlike(uid)
		if self.like > 0
			self.like = self.like - 1
		end
		# remove relationship
	end

	def add_to_schedule(uid)
		if self.hot < 0
			self.hot = 0
		end
		self.hot = self.hot + 1
		# add to schedule
	end

	def remove_from_schedule(uid)
		if self.hot > 0
			self.hot = self.hot - 1
		end

		# remove from schedule
	end

	private
	def init_model
		self.follow = 0
		self.like = 0
		self.hot = 0
	end
end
