class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable, 
  devise :database_authenticatable,
       :rememberable, :trackable, :validatable, :lockable,
       :registerable#, :confirmable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :title, :display, :phone, 
					:description, :name, :address, :student_no, :icon
	has_attached_file :icon, :styles => { :medium => "180x180>" }
  has_many :news
  has_many :information
  has_many :activities

	validates_presence_of :name, :student_no, :display, :address, :phone#, :description
	validates_uniqueness_of :name, :student_no, :display, :phone
	validates_length_of :description, :within => 0..200
	#validates_attachment_presence :icon

	before_create :lock

	def approve
		self.approved_at = Time.now
	end

	def unlock
  	self.failed_attempts = 0
  	self.unlock_token = ""
  	self.locked_at = nil
	end

	def lock
  	self.locked_at = Time.now
	end

  def can_destroy
    self.news.size == 0 && self.information.size == 0 && self.activities.size == 0 && self.role != "SuperAdmin"
  end

end
