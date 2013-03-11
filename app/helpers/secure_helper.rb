require 'openssl'

module SecureHelper
	def Decrypt(message)
		key = OpenSSL::PKey::RSA.new(File.read("#{Rails.configuration.rsa_private_key}"))
		key.private_decrypt(message)
	end
end
