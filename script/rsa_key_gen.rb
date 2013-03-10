require 'openssl'

sys_key = OpenSSL::PKey::RSA::generate(1024)

key_name = Time.now.strftime("%Y%m%d%H%M%S")

file_public = File.new("#{Rails.root}/config/keys/#{key_name}_public.pem", "w")
file_public.puts sys_key.public_key
file_public.close

file_private = File.new("#{Rails.root}/config/keys/#{key_name}_private.pem", "w")
file_private.puts sys_key.to_pem
file_private.close