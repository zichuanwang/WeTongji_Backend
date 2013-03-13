require 'openssl'

module SecureHelper
	def Decrypt(message)
		key = OpenSSL::PKey::RSA.new(File.read("#{Rails.configuration.rsa_private_key}"))
		key.private_decrypt(Base64.decode64(message))
	end
end
