class UserLike < ActiveRecord::Base
  attr_accessible :out_id, :out_model_name, :user_id
  paginates_per 20
end
