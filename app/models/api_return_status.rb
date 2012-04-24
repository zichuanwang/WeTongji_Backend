# encoding: utf-8
class ApiReturnStatus
  attr_reader :Id
  attr_reader :Memo
  
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
      when "999"
    end
  end
  
end
