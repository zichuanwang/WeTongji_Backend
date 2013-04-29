# encoding: utf-8
class ForStaff < Information

	validates :summary, :length => { :maximum => 30 }, :presence => true
	validates :source, :length => { :maximum => 30 }, :presence => true

	def source
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.source
	end

	def source=(src)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.source = src
	end

	def summary
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.summary
	end

	def summary=(sum)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.summary = sum
	end

end
