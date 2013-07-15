require 'test_helper'

class TongjiTest < ActiveSupport::TestCase
	test "try to convert captcha" do
		DataService::Tongji.verify_user('111', '222')
	  	assert true
	end
end
