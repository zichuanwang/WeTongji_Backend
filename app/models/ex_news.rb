class ExNews
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Image

	def self.init_from_news(news)
		model = ExNews.new
		model.Id = news.id
		model.Title = news.title
		model.Context = news.context
		model.Read = news.read
		model.CreatedAt = news.created_at
		model.Category = news.category
		model.Image = news.image == nil ? '' : Rails.configuration.host + news.image.url
		model
	end
end