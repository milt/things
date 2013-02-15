class Thing < ActiveRecord::Base
  attr_accessible :description, :name
  resourcify
end
