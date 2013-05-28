class Friend < ActiveRecord::Base
	belongs_to :user
	belongs_to :other_user, :class_name => "User", :foreign_key => "other_user_id"

	def self.break(this_one_id, that_one_id)
		friend_this = Friend.find_by_user_id_and_other_user_id(this_one_id, that_one_id)
		friend_that = Friend.find_by_user_id_and_other_user_id(that_one_id, this_one_id)
		unless friend_this.nil?
			friend_this.destroy
		end
		unless friend_that.nil?
			friend_that.destroy
		end
	end

	def self.connect(this_one_id, that_one_id)

		this_user = User.find_by_id(this_one_id)
		that_user = User.find_by_id(that_one_id)

		if !this_user.nil? && !that_user.nil?

			friend_this = Friend.find_by_user_id_and_other_user_id(this_one_id, that_one_id)
			if friend_this.nil?
				friend_this = Friend.new
				friend_this.user = this_user
				friend_this.other_user = that_user
				friend_this.save
			end

			friend_that = Friend.find_by_user_id_and_other_user_id(that_one_id, this_one_id)
			if friend_that.nil?
				friend_that = Friend.new
				friend_that.user = that_user
				friend_that.other_user = this_user
				friend_that.save
			end
		end
	end

	def self.keep?(this_user_id, that_user_id)
		return Friend.where("user_id = :this_id and other_user_id = :that_id", :this_id => this_user_id, :that_id => that_user_id).exists?
	end
end
