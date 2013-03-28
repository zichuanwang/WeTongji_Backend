# encoding: utf-8

ps = rand(1000000..9999999).to_s
u = User.new
u.no = '05171'
u.name = '金婕'
u.display_name = u.name
u.gender = '女'
u.department = '建筑与城市规划学院'
u.email = '66953352@qq.com'
u.user_type = "职工"
u.password = ps
u.confirmed_at = Time.now
profile = UserProfile.new
profile.init_default_setting
u.user_profile = profile
u.save

UserMailer.welcome_employee(u, ps).deliver