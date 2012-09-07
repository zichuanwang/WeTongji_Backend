class Sensitive < ActiveRecord::Base
	def self.words
		Sensitive.select(:word).uniq.map { |item| item.word  }.join(" ")
	end

	def self.check(context)
		Sensitive.all.each do |sen|
			if context.include?(sen.word)
				p "#{sen.word}===>#{context}"
				return true
			end
		end
		return false
	end
end
