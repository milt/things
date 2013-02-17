class Thing < ActiveRecord::Base
  attr_accessible :description, :name
  resourcify
  validates :name, :description, :presence => true
end
