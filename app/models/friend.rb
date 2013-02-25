class Friend < ActiveRecord::Base
	belongs_to :user
	has_one :other_user, :class_name => "User", :foreign_key => "other_user_id"

	def self.break(this_one, that_one)
		friend_this = Friend.find_by_user_id_and_other_user_id(this_one.id, that_one.id).first
		friend_that = Friend.find_by_user_id_and_other_user_id(that_one.id, this_one.id).first
		unless friend_this.nil?
			friend_this.destroy
		end
		unless friend_that.nil?
			friend_that.destroy
		end
	end
end
