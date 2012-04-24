class ApiReturn
  attr_accessor :status, :data
  
  def initialize(status_id)
    @status = ApiReturnStatus.new(status_id)
    @data = []
  end
  
end