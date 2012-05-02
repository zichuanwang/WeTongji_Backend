class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login], :reset_password_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login
  attr_accessor :login

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_uniqueness_of :uid

  before_create :init_model

  has_many :events
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :channles

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

  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if reset_password_token = conditions[:reset_password_token]
    where(conditions).where(["reset_password_token = ?", reset_password_token]).first
  else
    login = conditions.delete(:login).downcase
    where(conditions).where(["lower(no) = :value", { :value => login.downcase }]).first
  end
end
  
end
