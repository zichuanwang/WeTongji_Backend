class Version < ActiveRecord::Base
	attr_accessible :current, :latest, :url, :version
end
