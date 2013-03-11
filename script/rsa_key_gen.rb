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

#cert = OpenSSL::X509::Certificate.new(File.read("#{Rails.root}/config/keys/#wetongji_root_ca.pem"))


# # Create key
# key1 = OpenSSL::PKey::RSA.new(2048)
# open("private_key.pem", "w") do |io| io.write(key1.to_pem) end
# open("public_key.pem", "w") do |io| io.write(key1.public_key.to_pem) end
# puts("key1.private?=#{key1.private?}")

# # Export key
# cipher = OpenSSL::Cipher::Cipher.new("AES-128-CBC")
# pass_phrase = "this is my secure pass phrase"
# key1_secure = key1.export(cipher, pass_phrase)
# open("private_key.secure.pem", "w") do |io| io.write(key1_secure) end

# # Load key
# key2 = OpenSSL::PKey::RSA.new File.read("private_key.pem")
# puts("key2.private?=#{key2.private?}")

# key3 = OpenSSL::PKey::RSA.new(File.read("public_key.pem"))
# puts("key3.private?=#{key3.private?}")

# # Load encrypted key
# key4_pem = File.read("private_key.secure.pem")
# key4 = OpenSSL::PKey::RSA.new(key4_pem, pass_phrase)
# puts("key4.private?=#{key4.private?}")

# # Create cert
# name = OpenSSL::X509::Name.parse("CN=auralis/DC=topalis/DC=com")
# cert = OpenSSL::X509::Certificate.new()
# cert.version = 2
# cert.serial = 0
# cert.not_before = Time.new()
# cert.not_after = cert.not_before + (60*60*24*365)
# puts "cert.not_before=#{cert.not_before}"
# puts "cert.not_after=#{cert.not_after}"
# cert.public_key = key1.public_key
# cert.subject = name

# # Sign cert
# cert.issuer = name
# cert.sign key1, OpenSSL::Digest::SHA1.new()
# open("certificate.pem", "w") do |io| io.write(cert.to_pem) end

# # Load cert
# cert2 = OpenSSL::X509::Certificate.new(File.read("certificate.pem"))

# # Verify cert
# puts("cert2.verify key1=#{cert2.verify key1}")

# # Create CA key
# ca_key = OpenSSL::PKey::RSA.new(2048)
# open("ca_key.pem", "w") do |io| io.write(ca_key.export(cipher, pass_phrase)) end

# # Create CA cert
# ca_name = OpenSSL::X509::Name.parse("CN=ca/DC=topalis/DC=com")
# ca_cert = OpenSSL::X509::Certificate.new()
# ca_cert.serial = 0
# ca_cert.version = 2
# ca_cert.not_before = Time.new()
# ca_cert.not_after = ca_cert.not_before + (60*60*24*365)
# ca_cert.public_key = ca_key.public_key
# ca_cert.subject = ca_name
# ca_cert.issuer = ca_name
# extension_factory = OpenSSL::X509::ExtensionFactory.new()
# extension_factory.subject_certificate = ca_cert
# extension_factory.issuer_certificate = ca_cert
# extension_factory.create_extension("subjectKeyIdentifier", "hash")
# extension_factory.create_extension("basicConstraints", "CA:TRUE", true)
# extension_factory.create_extension("keyUsage", "cRLSign,keyCertSign", true)
# ca_cert.sign(ca_key, OpenSSL::Digest::SHA1.new())
# open("ca_cert.pem", "w") do |io| io.write(ca_cert.to_pem) end

# # Sign file
# # openssl smime -sign -in example.mobileconfig -out signed2.mobileconfig -signer ca_cert.pem -inkey ca_key.pem -outform der -nodetach
# profile = File.read("LBS_BausparApp.mobileprovision")
# profile_signed = OpenSSL::PKCS7.sign(ca_cert, ca_key, profile, [], OpenSSL::PKCS7::BINARY)
# open("signed.mobileconfig", "w") do |io| io.write(profile_signed.to_der) end

# # Encrypt file
# profile_encrypted = OpenSSL::PKCS7::encrypt([ca_cert], profile_signed.to_der, cipher, OpenSSL::PKCS7::BINARY)
# open("encrypted.mobileconfig", "w") do |io| io.write(profile_encrypted) end

# # Decrypt file
# profile_encrypted2 = OpenSSL::PKCS7.new(File.read("encrypted.mobileconfig"))
# profile_decrypted = profile_encrypted2.decrypt(ca_key, ca_cert)
# profile_signed2 = OpenSSL::PKCS7.new(profile_decrypted)
# puts "profile_signed2.signers()[0].name=#{profile_signed2.signers()[0].name}"

# # Verify
# # openssl smime -verify -inform der -in signed.mobileconfig -signer ca_cert.pem
# store = OpenSSL::X509::Store.new()
# store.add_cert(ca_cert)
# puts "profile_signed2.verify([ca_cert], store)=#{profile_signed2.verify([ca_cert], store)}"
# puts profile_signed2.data