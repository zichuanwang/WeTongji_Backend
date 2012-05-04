class User < ActiveRecord::Base
  attr_accessible :password

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_presence_of :no
  validates_uniqueness_of :no

  before_create :init_model
  after_create :send_confirmation

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
        user.display_name = user.name
        user.confirmation_token = Digest::SHA1.hexdigest(Time.now.strftime("%Y%m%d%H%M%S") + rand.to_s)
        return user
      end
    end
    nil
  end

  def self.authentication(no, password)
    user = User.find_by_no(no)
    if user && user.confirmed_at != nil && user.encrypted_password == User.hash_password(password, user.password_salt)
      user.last_seen_at = Time.now
      user.current_sign_in_at = user.last_seen_at
      user.sign_in_count = user.sign_in_count + 1
      user.last_sign_in_ip = ENV["HTTP_X_FORWARDED_FOR"]
      user.authentication_token = Digest::SHA1.hexdigest(user.uid + Time.now.strftime("%Y%m%d%H%M%S") + rand.to_s)
      user.save
      user
    end
  end

  def self.logoff(authentication_token)
    if authentication_token != nil && authentication_token != ''
      user = User.find_by_authentication_token(authentication_token)
      user.last_seen_at = Time.now
      user.authentication_token = nil
      user.save
    end
  end

  def password  
    @password  
  end  
    
  def password=(pwd)  
    @password = pwd
    return if pwd.blank?
    self.password_salt = new_salt  
    self.encrypted_password = User.hash_password(pwd, self.password_salt)  
  end

  def self.hash_password(password, salt)
    Digest::SHA1.hexdigest(password + salt) 
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

  def send_confirmation
    UserMailer.confirmation(self).deliver
  end

end
