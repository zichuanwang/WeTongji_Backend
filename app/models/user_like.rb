class UserLike < ActiveRecord::Base
  attr_accessible :out_id, :out_model_name, :user_id
  paginates_per 20

  def self.get_count(model, id)
  	UserLike.where("out_model_name = :name and out_id = :id and user_id is not null", :name => model, :id => id).count
  end

  def self.can?(model, id, user_id)
  	UserLike.where("out_model_name = :name and out_id = :id and user_id = :user_id", :name => model, :id => id, :user_id => user_id).exists?
  end
end
