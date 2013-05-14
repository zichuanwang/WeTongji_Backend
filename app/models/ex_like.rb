class ExLike
	attr_accessor :Id, :Model, :CreatedAt

	def self.init_from_like(like)
		model = ExLike.new
		model.Id = like.out_id
		model.Model = like.out_model_name
		model.CreatedAt = like.created_at
		model
	end
end