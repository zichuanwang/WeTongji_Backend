require 'openssl'

module SecureHelper
	def Decrypt(message)
		key = OpenSSL::PKey::RSA.new(File.read("#{Rails.configuration.rsa_private_key}"))
		key.private_decrypt(Base64.decode64(message))
	end

	def get_password
		psw = params[:Password]
		if params[:V] == "3.0"
			psw = Decrypt(params[:Password])
		end
		psw
	end
end
