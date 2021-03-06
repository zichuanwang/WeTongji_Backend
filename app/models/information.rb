# encoding: utf-8
class Information < ActiveRecord::Base
	has_one :information_external
	belongs_to :admin, :counter_cache => true
	has_many :information_images
	paginates_per 20
	validates_presence_of :title, :context, :category

	validates :title, :length => { :maximum => 30 }, :presence => true

	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "user_favorites", :foreign_key => "out_id", :conditions => "user_favorites.out_model_name = 'Information'"
	has_and_belongs_to_many :user_likes, :class_name => "User", :join_table => "user_likes", :foreign_key => "out_id", :conditions => "user_likes.out_model_name = 'Information'"

	before_create :init_model

	def check
		self.is_pending = Sensitive.check("#{self.title} #{self.context}")
		self.visiable = !self.is_pending
		if self.is_pending
			self.pending_reason = "含有不合适内容.等待管理员审核."
		end
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
			self.user_likes << user
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

	def can_favorite(user)
		!self.users_favorites.exists?(user)
	end

	def can_like(user)
		!self.user_likes.exists?(user)
	end

	private
	def init_model
		self.read = 1
		self.favorite = 0
		self.like = 0
	end
end
