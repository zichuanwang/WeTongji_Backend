# encoding: utf-8
require 'openssl'

sys_key = OpenSSL::PKey::RSA::generate(1024)

key_name = Time.now.strftime("%Y%m%d%H%M%S")

file_public = File.new("#{Rails.root}/config/keys/#{key_name}_public.pem", "w")
file_public.puts sys_key.public_key
file_public.close

file_private = File.new("#{Rails.root}/config/keys/#{key_name}_private.pem", "w")
file_private.puts sys_key.to_pem
file_private.close

file_public_der = File.new("#{Rails.root}/config/keys/#{key_name}_public.der", "w")
file_public_der.puts sys_key.public_key.to_der.force_encoding("utf-8")
file_public_der.close