# encoding: utf-8
class ApiReturnStatus
  attr_reader :id
  attr_reader :memo
  
  def initialize(id) 
    @id = id
    case id
      when "000"
        @memo = "成功。"
      when "001"
        @memo = "参数无法通过校验。"
      when "002"
        @memo = "方法无效。"
      when "003"
        @memo = "参数无效。"
      when "004"
        @memo = "缺少必要的系统参数。"
      when "999"
    end
  end
  
end
