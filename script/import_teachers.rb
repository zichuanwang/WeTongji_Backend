# encoding: utf-8
require 'action_view'
require 'csv'

p Rails.root
p "#{Rails.root}/public/imports/teachers.csv"
csv_text = File.read("#{Rails.root}/public/imports/teachers.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	p = rand(7).to_s
	u = User.new
	u.no = row[0]
	u.name = row[1]
	u.display_name = u.name
	u.gender = row[2]
	u.department = row[3]
	u.birthday = row[4]
	u.email = row[5]
	u.user_type = "职工"
	u.password = p
	u.confirmed_at = Time.now
	profile = UserProfile.new
	profile.init_default_setting
	u.user_profile = profile
	u.save

	UserMailer.welcome_employee(u, p).deliver
  	p "import no:#{index} row!"
end
e = Time.now