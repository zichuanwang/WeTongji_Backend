class Channel < ActiveRecord::Base
	has_many :activities
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_and_belongs_to_many :users

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

	private
	def init_model
		self.follow = 0
	end

end