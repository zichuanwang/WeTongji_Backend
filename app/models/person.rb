class Person < ActiveRecord::Base
	validates_presence_of :description, :name, :job_title, :words, :no
	validates_uniqueness_of :no

	has_and_belongs_to_many :users_likes, :class_name => "User", :join_table => "user_likes", :foreign_key => "out_id", :conditions => "user_likes.out_model_name = 'Person'"

	validates_attachment :avatar, :presence => true, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	has_many :person_images
	
  	before_create :init_model
  	paginates_per 20

	private
	def init_model
		self.read = 1
	end
end
