# encoding: utf-8
class ClubNewsTmp < ActiveRecord::Base
	self.table_name = "club_news"
	belongs_to :admin
	has_many :club_news_images, :foreign_key => "club_news_id"
	paginates_per 20
	validates_presence_of :context

	validates :title, :length => { :maximum => 30 }, :presence => true

	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "club_news_users_favorites", :foreign_key => "club_news_id"
	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "club_news_users_likes", :foreign_key => "club_news_id"

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

	def can_favorite(user)
		!self.users_favorites.exists?(user)
	end

	def can_like(user)
		!self.users_likes.exists?(user)
	end

	private
	def init_model
		self.read = 1
		self.favorite = 0
		self.like = 0
	end
end