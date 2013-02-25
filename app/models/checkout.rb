class Checkout < ActiveRecord::Base
  attr_accessible :pickup_at, :return_at, :user
  belongs_to :user
  has_many :allocations, :dependent => :delete_all
  has_many :things, :through => :allocations
  validates :user, :pickup_at, :return_at, :presence => true
end
