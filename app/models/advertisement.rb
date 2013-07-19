class Advertisement < ActiveRecord::Base
  	attr_accessible :title, :url, :read, :image, :publisher

  	validates_presence_of :title, :url, :publisher

	paginates_per 20

	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_create :init_model

	private
	def init_model
		self.read = 1
	end
end
