class InformationExternal < ActiveRecord::Base
  attr_accessible :contact, :has_ticket, :location, :source, :summary, :tags
end
