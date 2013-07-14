class Person < ActiveRecord::Base
	validates_presence_of :description, :name, :job_title, :words, :no
	validates_uniqueness_of :no

	#has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "user_favorites", :foreign_key => "out_id", :conditions => "user_favorites.out_model_name = 'Person'"
	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "user_likes", :foreign_key => "out_id", :conditions => "user_likes.out_model_name = 'Person'"

	validates_attachment :avatar, :presence => true, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	has_many :person_images
	
  	before_create :init_model
  	paginates_per 20

	# def user_favorite(user)
	# 	if self.favorite < 0
	# 		self.favorite = 0
	# 	end
		
	# 	if user && !self.users_favorites.exists?(user)
	# 		self.users_favorites << user
	# 		self.favorite += 1
	# 	end
	# end

	# def user_unfavorite(user)
	# 	# remove from user favorite
	# 	if user && self.users_favorites.exists?(user)
	# 		self.users_favorites.delete(user)
	# 		self.favorite -= 1
	# 	end

	# 	if self.favorite < 0
	# 		self.favorite = 0
	# 	end
	# end

	# def user_like(user)
	# 	if self.like < 0
	# 		self.like = 0
	# 	end
	# 	# add to user like
	# 	if user && !self.users_likes.exists?(user)
	# 		self.users_likes << user
	# 		self.like += 1
	# 	end
	# end

	# def user_unlike(user)
	# 	if user && self.users_likes.exists?(user)
	# 		self.users_likes.delete(user)
	# 		self.like -= 1
	# 	end

	# 	if self.like < 0
	# 		self.like = 0
	# 	end
	# end

	# def can_favorite(user)
	# 	!self.users_favorites.exists?(user)
	# end

	# def can_like(user)
	# 	!self.users_likes.exists?(user)
	# end

	private
	def init_model
		self.read = 1
		# self.like = 0
		# self.favorite = 0
	end
end
