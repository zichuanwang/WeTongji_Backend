class Function
	attr_accessor :Name, :Params, :NeedAuth, :Returns, :Description

	def initialize
		@Params = []
		@Returns = []
	end
end