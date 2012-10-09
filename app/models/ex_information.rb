class ExInformation
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Image

	def self.init_from_information(information)
		model = ExInformation.new
		model.Id = information.id
		model.Title = information.title
		model.Context = information.context
		model.Read = information.read
		model.CreatedAt = information.created_at
		model.Category = information.category
		model.Image = information.image == nil ? '' : Rails.configuration.host + information.image.url
		model
	end
end