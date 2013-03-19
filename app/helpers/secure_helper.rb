require 'openssl'

module SecureHelper
	def Decrypt(message)
		key = OpenSSL::PKey::RSA.new(File.read("#{Rails.configuration.rsa_private_key}"))
		p "====="
		p Base64.decode64(message).length
		key.private_decrypt(Base64.decode64(message))
	end

	def get_password
		psw = params[:Password]
		if params[:V] == "2.0"
			psw = Decrypt(params[:Password])
		end
		psw
	end
end
