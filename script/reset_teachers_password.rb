# encoding: utf-8
User.where("last_seen_at is null and user_type = '职工'").each_with_index do |item, index|
  ps = rand(1000000..9999999).to_s
	item.password = ps
  item.save
	UserMailer.new_password(item, ps).deliver
  	p "import no:#{index} row!"
end
