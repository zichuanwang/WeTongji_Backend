class ApiReturn
  attr_accessor :Status, :Data
  
  def initialize(status_id)
    @Status = ApiReturnStatus.new(status_id)
    @Data = []
  end
  
end