class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_uniqueness_of :uid

  before_create :init_model

  has_many :events
  has_and_belongs_to_many :activities

  private
  def init_model
  	self.uid = new_uid
  end

  def new_uid
  	uid = Time.now.strftime("%Y%m%d%H%M%S") + SecureRandom.random_number(10).to_s
  	if User.find_by_uid(self.uid)
  		new_uid
  	else
  		uid
  	end
  end
  
end
