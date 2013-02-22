class Checkout < ActiveRecord::Base
  attr_accessible :pickup_at, :return_at, :user
  belongs_to :user
  has_many :allocations
  has_many :things, :through => :allocations
end
