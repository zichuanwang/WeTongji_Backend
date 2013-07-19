class ExAdvertisement
	attr_accessor :Id, :Title, :Image, :Publisher, :URL

	def self.init_from_advertisement(advertisement)
		model = ExAdvertisement.new
		model.Id = advertisement.id
		model.Title = advertisement.title
		model.URL = advertisement.url
		model.Image = advertisement.image == nil ? '' : Rails.configuration.host + advertisement.image.url(:medium)
		model.Publisher = advertisement.publisher

		model
	end
end