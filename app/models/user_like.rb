class UserLike < ActiveRecord::Base
  attr_accessible :out_id, :out_model_name, :user_id
  paginates_per 20

  def self.get_count(model, id)
  	UserLike.where("out_model_name = :name and out_id = :id and user_id is not null", :name => model, :id => id).count
  end
end
