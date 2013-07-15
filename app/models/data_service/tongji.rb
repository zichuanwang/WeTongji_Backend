require 'net/http'
require 'rtesseract'
require 'mini_magick'

class DataService::Tongji
  host = "http://xuanke.tongji.edu.cn/"
  user_name_key = "Login.Token1"
  user_password_key = "Login.Token2"
  captcha_key = "T3"
  form_action = "index2.jsp"

  def self.verify_user(student_no, password)
  	#load captcha from index page
  	url = URI.parse("http://xuanke.tongji.edu.cn/")
  	req = Net::HTTP::Get.new(url.path)
  	res = Net::HTTP.start(url.host, url.port){ |http|
  		http.request(req)
  	}

    #get session and cookie with captcha
    file_resp = Net::HTTP.get_response(URI("http://xuanke.tongji.edu.cn/CheckImage"))
    File.open("public/captcha.gif", "wb") do |file|
      file.write(file_resp.body)
      file.close
    end
    image_middleware = MiniMagick::Image.new("public/captcha.gif")
    image_middleware.crop("#{image_middleware[:width] - 2}x#{image_middleware[:height] - 2}+1+1")

    image = RTesseract.new(image_middleware.path)

    puts image.to_s

  	#puts res.body
  end
end
