class ExAccount
	attr_accessor :Id, :Name, :Description, :Display, :Image, :Like, :Background, :ActivitiesCount, :InformationCount, :Title, :Email, :CanLike

	def self.init_from_account(account, user = nil)
		model = ExAccount.new
		unless account.nil?
			model.Id = account.id
			model.Name = account.name
			model.Display = account.display
			model.Description = account.description
			model.Title = account.title
			model.Email = account.email
			model.Like = UserLike.get_count("Account", model.Id)
			model.CanLike = user.nil? ? false : UserLike.can?("Account", account.id, user.id)
			model.Image = !account.icon.exists? ? '' : Rails.configuration.host + account.icon.url(:medium)
			model.Background = !account.background.exists? ? '' : Rails.configuration.host + account.background.url(:medium)
			model.ActivitiesCount = account.activities.count
			model.InformationCount = account.information.count
		end

		model
	end
end