class Admin < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable, 
  	devise :database_authenticatable,
         :rememberable, :trackable, :validatable, :lockable

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :title, :display, :phone, 
  					:description, :name, :address, :student_no
	has_attached_file :icon, :styles => { :medium => "180x180>", :thumb => "100x100>" }
  	has_one :organizer
end
