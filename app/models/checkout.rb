class Checkout < ActiveRecord::Base
  attr_accessible :pickup_at, :return_at, :user
  belongs_to :user
  has_many :allocations, :dependent => :delete_all
  has_many :things, :through => :allocations
  validates :user, :pickup_at, :return_at, :presence => true
  scope :reservation, where(picked_up: nil, returned: nil)
  scope :active, where("picked_up IS NOT NULL AND returned IS NULL")
  scope :returned, where("picked_up IS NOT NULL AND returned IS NOT NULL")

  def status
    return :reservation if picked_up.nil? && returned.nil?
    return :active if picked_up.present? && returned.nil?
    return :returned if picked_up.present? && returned.present?
  end
end
