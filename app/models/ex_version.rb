class ExVersion
  	attr_accessor :Current, :Latest, :Url

	def self.init_from_version(version)
		model = ExVersion.new
		model.Current = version.current
		model.Latest = version.latest
		model.Url = version.url
		model
	end
end