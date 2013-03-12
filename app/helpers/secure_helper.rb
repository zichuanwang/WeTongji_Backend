require 'openssl'

module SecureHelper
	def Decrypt(message)
		key = OpenSSL::PKey::RSA.new(File.read("#{Rails.configuration.rsa_private_key}"))
		# p
		# p message
		# p Base64.decode64(message)
		# p "========"
		# key2 = OpenSSL::PKey::RSA.new(File.read("#{Rails.root}/config/keys/20130312233245_public.pem"))
		# 10.times {
		# 	p Base64.encode64(key2.public_encrypt('111111'))
		# 	p key2.public_encrypt('111111').length
		# }
		# p OpenSSL::PKey::RSA::NO_PADDING
		# p Base64.encode64(key2.public_encrypt('111111'))
		# p "======="
		# #p key.private_decrypt(Base64.encode64(key2.public_encrypt('111111', OpenSSL::PKey::RSA::NO_PADDING)), OpenSSL::PKey::RSA::NO_PADDING)
		# p "============"

		p key.private_decrypt(Base64.decode64(message))

		key.private_decrypt(Base64.decode64(message))

	end
end
