class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout
  belongs_to :user, :through => :checkout
  attr_accessible :checkout
end
