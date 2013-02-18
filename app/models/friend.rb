class Friend < ActiveRecord::Base
	belongs_to :user
	has_one :other_user, :class_name => "User", :foreign_key => "other_user_id"

	def self.invite(from, to)
		
	end

	def self.accept(from, to)
		
	end
	def self.reject(from, to)
		
	end
end
