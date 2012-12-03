class ExEvent
	attr_accessor :Id, :Title, :Begin, :End, :Location, :Description

	def self.init_from_event(instance)
		model = ExEvent.new
		model.Id = event.id
		model.Title = event.title
		model.Begin = event.begin
		model.End = event.end
		model.Location = event.location
		model.Description = channel.description.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
		model
	end
end