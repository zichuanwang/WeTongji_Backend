class UserFavorite < ActiveRecord::Base
  attr_accessible :out_id, :out_model_name, :user_id
end
