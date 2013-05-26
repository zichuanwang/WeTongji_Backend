class Report < ActiveRecord::Base
  attr_accessible :out_id, :out_model_name, :reason, :user_id
end
