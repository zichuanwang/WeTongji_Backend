# encoding: utf-8
User.where("last_seen_at is null and user_type = '教师'").each do |item|
  
end
