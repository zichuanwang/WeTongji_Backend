class Admin < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable, 
  	devise :database_authenticatable,
         :rememberable, :trackable, :validatable, :lockable,
         :registerable, :confirmable

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :title, :display, :phone, 
  					:description, :name, :address, :student_no, :icon
	has_attached_file :icon, :styles => { :medium => "180x180>" }
  	has_one :organizer

	validates_presence_of :name, :student_no, :display, :address, :phone, :description
	validates_uniqueness_of :name, :student_no, :display, :phone
	validates_length_of :description, :within => 0..200
	validates_attachment_presence :icon
end
