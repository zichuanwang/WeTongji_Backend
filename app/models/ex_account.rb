class ExAccount
	attr_accessor :Id, :Name, :Description, :Display, :Image

	def self.init_from_account(account, user = nil)
		model = ExAccount.new
		model.Id = account.id
		model.Name = account.name
		model.Display = account.display
		model.Description = account.description
		model.Image = account.icon == nil ? '' : Rails.configuration.host + account.icon.url(:medium)
		model
	end
end