class Person < ActiveRecord::Base
	attr_accessible :description, :name, :read, :title, :job_title, :words, :like, :favorite

	has_and_belongs_to_many :users_favorites, :class_name => "User", :join_table => "people_users_favorites"
	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "people_users_likes"

	has_many :person_images
	
  	before_create :init_model
  	paginates_per 20

	private
	def init_model
		self.read = 0
		self.like = 0
		self.favorite = 0
	end
end
