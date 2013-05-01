class ExBanner
	attr_accessor :Id, :Title, :Image

	def self.init_from_banner(banner)
		model = ExBanner.new
		model.Id = banner.id
		model.Title = banner.title
		model.Image = banner.image == nil ? '' : Rails.configuration.host + banner.image.url(:medium)

		model
	end
end