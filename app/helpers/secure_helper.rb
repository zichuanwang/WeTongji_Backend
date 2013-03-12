require 'openssl'

module SecureHelper
	def Decrypt(message)
		key = OpenSSL::PKey::RSA.new(File.read("#{Rails.configuration.rsa_private_key}"))
		#p key
		#p message
		# p Base64.decode64(message)
		# p "========"
		# key2 = OpenSSL::PKey::RSA.new(File.read("#{Rails.root}/config/keys/20130312015851_public.pem"))
		# p key2.public_encrypt('11111100000000000000000000000000000000')
		# p "======="
		# p key.private_decrypt(key2.public_encrypt('11111100000000000000000000000000000000'))
		# p "============"
		# key3 = OpenSSL::X509::Certificate.new(File.read("#{Rails.root}/config/keys/20130312015851_public.der"))
		# p key3.public_key.public_encrypt('11111100000000000000000000000000000000')
		# p "=========="
		# p key.private_decrypt(key3.public_key.public_encrypt('11111100000000000000000000000000000000'))
		key.private_decrypt(Base64.decode64(message))

	end
end
