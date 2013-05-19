class ExAdvertisement
	attr_accessor :Id, :Title, :Image, :BgColor, :Publisher

	def self.init_from_advertisement(advertisement)
		model = ExAdvertisement.new
		model.Id = advertisement.id
		model.Title = advertisement.title
		model.BgColor = advertisement.bgcolor
		model.Image = advertisement.image == nil ? '' : Rails.configuration.host + advertisement.image.url(:medium)
		model.Publisher = advertisement.publisher

		model
	end
end