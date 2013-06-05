class Thing < ActiveRecord::Base
  #attr_accessible :description, :name
  resourcify
  validates :name, :description, :presence => true
  has_many :allocations
  has_many :checkouts, :through => :allocations
end
