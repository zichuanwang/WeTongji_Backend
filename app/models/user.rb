class User < ActiveRecord::Base
  attr_accessible :password

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_presence_of :no
  validates_uniqueness_of :no

  paginates_per 20

  before_create :init_model
  after_create :send_confirmation
  has_and_belongs_to_many :favorite_activities, :class_name => "Activity", :join_table => "activities_users_favorites", :order => "begin asc"
  has_and_belongs_to_many :schedule_activities, :class_name => "Activity", :join_table => "activities_users_schedules", :order => "begin asc"
  has_and_belongs_to_many :favorite_arounds, :class_name => "Around", :join_table => "arounds_users_favorites", :order => "id desc"
  has_and_belongs_to_many :favorite_club_news, :class_name => "ClubNews", :join_table => "club_news_users_favorites", :order => "id desc"
  has_and_belongs_to_many :favorite_for_staffs, :class_name => "ForStaff", :join_table => "for_staffs_users_favorites", :order => "id desc"
  has_and_belongs_to_many :favorite_school_news, :class_name => "SchoolNews", :join_table => "school_news_users_favorites", :order => "id desc"
  has_and_belongs_to_many :favorite_people, :class_name => "Person", :join_table => "people_users_favorites", :order => "id desc"
  has_one :user_profile

  has_many :sent_invites, :class_name => "FriendInvite", :foreign_key => "from"
  has_many :received_invites, :class_name => "FriendInvite", :foreign_key => "to"
  has_many :friends

  def self.active_user_from_student(no, name, password)
    student = Student.find_by_no_and_name(no, name)
    if student
      user = User.find_by_no(no)
      if user.nil?
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
        user.confirmation_token = Digest::SHA1.hexdigest(Time.now.strftime("%Y%m%d%H%M%S%L") + rand.to_s)
        user
      elsif user.confirmed_at.nil?
        if user.confirmation_token.nil? || user.confirmation_token.blank?
          user.confirmation_token = Digest::SHA1.hexdigest(Time.now.strftime("%Y%m%d%H%M%S%L") + rand.to_s)
        end
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
      user.authentication_token = Digest::SHA1.hexdigest(user.uid + Time.now.strftime("%Y%m%d%H%M%S%L") + rand.to_s)
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

  def self.find_with_no_and_name(no, name)
    user = User.find_by_no_and_name(no, name)
    unless user.user_profile.nil? && user.user_profile.can_be_found == false
      return nil
    end
    return user
  end

  def logoff(uid, authentication_token)
    if self.uid == uid && self.authentication_token == authentication_token
      self.last_seen_at = Time.now
      self.authentication_token = nil
    end
  end

  def update_password(password_old, password_new)
    if password_new != nil && password_new != '' && self.encrypted_password == User.hash_password(password_old, self.password_salt)
      self.password = password_new
      self.authentication_token = Digest::SHA1.hexdigest(self.uid + Time.now.strftime("%Y%m%d%H%M%S%L") + rand.to_s)
      self.reset_password_token = nil
      self.last_seen_at = Time.now
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

  def send_reset_password_mail
    if self.reset_password_token.nil? || self.reset_password_token.blank?
      self.reset_password_token = Digest::SHA1.hexdigest(self.uid + Time.now.strftime("%Y%m%d%H%M%S%L") + rand.to_s)
    end
    UserMailer.reset_password(self).deliver
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
