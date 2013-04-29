# encoding: utf-8
class Around < Information

	validates :summary, :length => { :maximum => 30 }, :presence => true
	validates :source, :length => { :maximum => 30 }, :presence => true
	validates :ticket_service, :presence => true, :if => Proc.new { |a| a.has_ticket }
	before_save :set_ticket

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

	def tags
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.tags
	end

	def tags=(t)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.tags = t
	end

	def has_ticket
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.has_ticket
	end

	def has_ticket=(t)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.has_ticket = t
	end

	def location
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.location
	end

	def location=(t)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.location = t
	end

	def contact
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.contact
	end

	def contact=(t)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.contact = t
	end

	def ticket_service
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.ticket_service
	end

	def ticket_service=(t)
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.ticket_service = t
	end

	def has_ticket
		if self.information_external.nil?
			self.information_external = InformationExternal.new
		end
		self.information_external.has_ticket
	end

	def set_ticket
		unless self.has_ticket
			self.ticket_service = nil
		end
	end
end

