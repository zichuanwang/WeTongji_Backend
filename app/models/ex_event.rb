class ExEvent
	attr_accessor :Id, :Title, :Begin, :End, :Location, :Description

	def self.init_from_event(event)
		model = ExEvent.new
		model.Id = event.id
		model.Title = event.title
		model.Begin = event.begin
		model.End = event.end
		model.Location = event.location
		model.Description = channel.description
		model
	end
end