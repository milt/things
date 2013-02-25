class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout
  has_one :user, :through => :checkout
  attr_accessible :checkout
  validates :checkout, :thing, :pickup_at, :return_at, :presence => true
end
