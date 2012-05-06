# encoding: utf-8
class ApiReturnStatus
  attr_reader :Id, :Memo
  
  def initialize(id) 
    @Id = id
    case id
      when "000"
        @Memo = "成功。"
      when "001"
        @Memo = "参数无法通过校验。"
      when "002"
        @Memo = "方法无效。"
      when "003"
        @Memo = "参数无效。"
      when "004"
        @Memo = "缺少必要的系统参数。"
      when "005"
        @Mmeo = "未获得权限，请登录。"
      when "006"
        @Memo = "登录超时，请重新登录。"
      when "007"
        @Memo = "缺少方法必须的参数。"
      when "010"
        @Memo = "密码不符合规范。"
      when "999"
        @Memo = "UnKnown"
    end
  end
  
end
