class Checkout < ActiveRecord::Base
  attr_accessible :pickup_at, :return_at, :user
  belongs_to :user
  has_many :allocations, :dependent => :delete_all
  has_many :things, :through => :allocations
  validates :user, :pickup_at, :return_at, :presence => true
  scope :reservation, lambda { where("pickup_at > ?", DateTime.now) }

  def status
    if picked_up.nil?
      :reservation if pickup_at >= DateTime.now else :late_for_pickup
    end

    if picked_up.present? && returned.nil?
      :active if return_at >= DateTime.now else :overdue
    end

    if returned.present?
      :returned if returned >= return_at else :late_return
    end
  end
end
