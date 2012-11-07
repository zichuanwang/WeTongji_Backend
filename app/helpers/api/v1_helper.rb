module Api
	module V1Helper
		include Api::BaseHelper
		include Api::ChannelsHelper
		include Api::ActivitiesHelper
		include Api::NewsHelper
		include Api::UsersHelper
		include Api::UserProfileHelper
		include Api::InformationHelper
	end
end