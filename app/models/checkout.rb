class Checkout < ActiveRecord::Base
  attr_accessible :user, :user_id, :pickup_at, :return_at
  belongs_to :user
  has_many :allocations, :dependent => :delete_all
  has_many :things, :through => :allocations
  validates :user, :presence => true

  # scope :reservation, where(picked_up: nil, returned: nil)
  # scope :active, where("picked_up IS NOT NULL AND returned IS NULL")
  # scope :returned, where("returned IS NOT NULL")

  # scope :late_pickup, lambda { reservation.where("pickup_at < ?", DateTime.now) }
  # scope :overdue, lambda { active.where("return_at < ?", DateTime.now) }
  # scope :late_return, lambda { returned.where("return_at < returned") }



  # def status
  #   return :reservation if picked_up.nil? && returned.nil?
  #   return :active if picked_up.present? && returned.nil?
  #   return :returned if picked_up.present? && returned.present?
  # end

  # def problem
  #   case status
  #   when :reservation
  #     return :late_pickup if pickup_at < DateTime.now
  #     return false
  #   when :active
  #     return :overdue if return_at < DateTime.now
  #     return false
  #   when :returned
  #     return :late_return if returned > return_at
  #     return false
  #   else
  #     return false
  #   end
  # end
end
