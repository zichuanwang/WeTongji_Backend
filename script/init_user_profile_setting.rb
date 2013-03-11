User.all.each do |u|
	if u.user_profile.nil?
		p = UserProfile.new
		p.init_default_setting
		u.user_profile = p
		u.save
	end
end