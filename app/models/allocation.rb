class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout
  has_one :user, :through => :checkout
  attr_accessible :thing, :checkout, :pickup_at, :return_at, :picked_up, :returned
  validates :checkout, :thing, :pickup_at, :return_at, :presence => true
end
