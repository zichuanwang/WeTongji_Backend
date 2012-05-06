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
      if user == nil
        user = User.new
        user.email = student.email
        user.no = student.no
        user.name = student.name
        user.password = password
        user.display_name = user.name
        user.major = student.major
        user.native_place = student.native_place
        user.degree = student.degree
        user.department = student.department
        user.birthday = student.birthday
        user.year = student.year
        user.plan = student.plan
        user.gender = student.gender
        user.confirmation_token = Digest::SHA1.hexdigest(Time.now.strftime("%Y%m%d%H%M%S") + rand.to_s)
        user
      elsif user.confirmed_at == nil
        user.confirmation_token = Digest::SHA1.hexdigest(Time.now.strftime("%Y%m%d%H%M%S") + rand.to_s)
        user
      end
    end
  end

  def self.authentication(no, password)
    user = User.where("no = :no and confirmed_at is not null", :no => no).first
    if user && user.encrypted_password == User.hash_password(password, user.password_salt)
      user.last_seen_at = Time.now
      user.current_sign_in_at = user.last_seen_at
      user.sign_in_count = user.sign_in_count + 1
      user.last_sign_in_ip = ENV["HTTP_X_FORWARDED_FOR"]
      user.authentication_token = Digest::SHA1.hexdigest(user.uid + Time.now.strftime("%Y%m%d%H%M%S") + rand.to_s)
      user
    end
  end

  def self.get_authentication_user(uid, authentication_token)
    user = User.find_by_uid_and_authentication_token(uid, authentication_token)
    if user
      user.last_seen_at = Time.now
      user
    else
      nil
    end
  end

  def logoff(uid, authentication_token)
    if self.uid == uid && self.authentication_token == authentication_token
      user.last_seen_at = Time.now
      user.authentication_token = nil
    end
  end

  def update_password(password_old, password_new)
    if password_new != nil && password_new != '' && self.encrypted_password == User.hash_password(password_old, user.password_salt)
      self.password = password_new
    end
  end

  def password  
    @password  
  end
    
  def password=(pwd)  
    @password = pwd
    return if !User.is_password_valid?(pwd)
    self.password_salt = new_salt  
    self.encrypted_password = User.hash_password(pwd, self.password_salt)  
  end

  def self.is_password_valid?(pwd)
    !pwd.match(/[A-Z0-9a-z_]{6,}/).nil?
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
