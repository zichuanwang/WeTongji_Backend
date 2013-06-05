class ExAccount
	attr_accessor :Id, :Name, :Description, :Display, :Image

	def self.init_from_account(account, user = nil)
		model = ExAccount.new
		unless account.nil?
			model.Id = account.id
			model.Name = account.name
			model.Display = account.display
			model.Description = account.description
			model.Image = account.icon == nil ? '' : Rails.configuration.host + account.icon.url(:medium)
		end

		model
	end
end