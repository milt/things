class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout
  has_one :user, :through => :checkout
  attr_accessible :checkout
end
