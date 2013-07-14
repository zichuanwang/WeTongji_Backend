require 'net/http'

class DataService::Tongji
  host = "http://xuanke.tongji.edu.cn/"
  user_name_key = "Login.Token1"
  user_password_key = "Login.Token2"
  captcha_key = "T3"
  form_action = "index2.jsp"

  def verify_user(student_no, password)
  	#load captcha from index page
  	url = URI.parse(host)
  	req = Net::HTTP::Get.new(url.path)
  	res = Net::HTTP.start(url.host, url.port){ |http|
  		http.request(req)
  	}

  	puts res.body
  end
end
