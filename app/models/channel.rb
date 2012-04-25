class Channel < ActiveRecord::Base
	has_many :activities
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_create :init_model

	private
	def init_model
		self.follow = 0
	end

end