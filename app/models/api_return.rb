class ApiReturn
  attr_accessor :Status, :Data
  
  def initialize(status_id)
    @Status = ApiReturnStatus.new(status_id)
    @Data = {}
  end

  def add_data(key, value)
  	@Data[key] = value
  end
  
end