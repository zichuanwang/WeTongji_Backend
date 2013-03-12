require 'openssl'

key = OpenSSL::PKey::RSA.new(1024)
digest = OpenSSL::Digest::SHA1.new()

issu = sub = OpenSSL::X509::Name.new()
sub.add_entry('C', 'JP')
sub.add_entry('ST', 'Shimane')
sub.add_entry('CN', 'Ruby Taro')

cer = OpenSSL::X509::Certificate.new()
cer.not_before = Time.at(0)
cer.not_after = Time.at(0)
cer.public_key = key  # <= 接受签署的公匙 
cer.serial = 1
cer.issuer = issu
cer.subject = sub

cer.sign(key, digest) # <= 签署用的秘匙和哈希表函数
print cer.to_text
#print cer.to_der