class Sensitive < ActiveRecord::Base
	def self.words
		Sensitive.select(:word).uniq.map { |item| item.word  }.join(" ")
	end
end
