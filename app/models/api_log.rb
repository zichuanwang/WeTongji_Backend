class ApiLog < ActiveRecord::Base
  attr_accessible :d, :m, :u, :v, :begin, :end, :duration
end
