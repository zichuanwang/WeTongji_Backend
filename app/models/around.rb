# encoding: utf-8
class Around < ActiveRecord::Base
	belongs_to :admin
	has_many :around_images
	paginates_per 20
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	validates_presence_of :context

	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }
	

	validates :ticket_service, :presence => true, :if => Proc.new { |a| a.has_ticket }
	validates :contact, :presence => true, :if => Proc.new { |a| a.has_ticket }
	validates :location, :presence => true, :if => Proc.new { |a| a.has_ticket }

	validates :title, :length => { :maximum => 30 }, :presence => true
	validates :summary, :length => { :maximum => 30 }, :presence => true
	validates :source, :length => { :maximum => 30 }, :presence => true

	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "arounds_users_favorites"
	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "arounds_users_likes"

	before_create :init_model
	before_save :set_ticket

	def check
		self.is_pending = Sensitive.check("#{self.title} #{self.context} #{self.source}")
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

	def set_ticket
		unless self.has_ticket
			self.contact = nil
			self.ticket_service = nil
			self.location = nil
		end
	end
end

