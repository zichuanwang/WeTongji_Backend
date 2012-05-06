# encoding: utf-8
class ApiReturnStatus
  attr_reader :Id, :Memo

  STATUS = {
    "000" => "成功。",
    "001" => "参数无法通过校验。",
    "002" => "方法无效。",
    "003" => "参数无效。",
    "004" => "缺少必要的系统参数。",
    "005" => "未获得权限，请登录。",
    "006" => "登录超时，请重新登录。",
    "007" => "缺少方法必须的参数。",
    "010" => "密码不符合规范。",
    "999" => "未知错误。"
  }
  
  def initialize(id) 
    @Id = id
    @Memo = STATUS[id]
  end
  
end
