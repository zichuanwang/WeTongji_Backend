class ExNews
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Image

	def self.init_from_news(news)
		model = ExNews.new
		model.Id = news.id
		model.Title = news.title
		model.Context = news.context.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
		model.Read = news.read
		model.CreatedAt = news.created_at
		model.Category = news.category
		model.Image = !news.image.exists? ? '' : Rails.configuration.host + news.image.url
		model
	end
end