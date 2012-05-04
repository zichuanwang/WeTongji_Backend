class User < ActiveRecord::Base
  attr_accessible :password

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_presence_of :no
  validates_uniqueness_of :no

  before_create :init_model

  def self.active_user_from_student(no, name, password)
    student = Student.find_by_no_and_name(no, name)
    if student
      user = User.find_by_no(no)
      unless user
         user = User.new
         user.email = student.email
         user.no = student.no
         user.name = student.name
         user.password = password
         return user
      end
    end
    nil
  end

  def password  
    @password  
  end  
    
  def password=(pwd)  
    @password = pwd
    return if pwd.blank?
    self.password_salt = new_salt  
    self.encrypted_password = Digest::SHA1.hexdigest(pwd + self.password_salt)  
  end 

  private
  def init_model
    self.uid = new_uid
  end

  def new_uid
    uid = Time.now.strftime("%Y%m%d%H%M%S") + SecureRandom.random_number(10).to_s
    if User.find_by_uid(uid)
      new_uid
    else
      uid
    end
  end

  def new_salt
    Digest::SHA1.hexdigest(self.object_id.to_s + rand.to_s)
  end


end
