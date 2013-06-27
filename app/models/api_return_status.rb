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
    "008" => "用户已经注册。",
    "009" => "学号姓名不匹配。",
    "010" => "密码不符合规范。",
    "011" => "账号未激活。",
    "012" => "没有该学号。",
    "013" => "账号密码不匹配。",
    "014" => "该学号未注册账号。",
    "015" => "该学号不允许添加为好友。",
    "016" => "数据已经过时,请获取最新状态。",
    "017" => "没有该对象的操作权限。",
    "018" => "请求数据太多,请分批次请求。",
    "999" => "未知错误。"
  }
  
  def initialize(id) 
    @Id = id
    @Memo = STATUS[id]
  end
  
end
