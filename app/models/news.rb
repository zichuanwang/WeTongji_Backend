class News < ActiveRecord::Base
	paginates_per 20
	validates_presence_of :title, :content
end
