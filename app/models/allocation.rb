class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout
  has_one :user, :through => :checkout
  attr_accessible :thing, :checkout, :picked_up, :returned
  validates :checkout, :thing, :presence => true
  delegate :pickup_at, :return_at, to: :checkout

  # scope :reservation, where(picked_up: nil, returned: nil)
  # scope :active, where("picked_up IS NOT NULL AND returned IS NULL")
  # scope :returned, where("returned IS NOT NULL")

  # scope :late_pickup, lambda { reservation.where("pickup_at < ?", DateTime.now) }
  # scope :overdue, lambda { active.where("return_at < ?", DateTime.now) }
  # scope :late_return, lambda { returned.where("return_at < returned") }

  def status
    return :reserved if picked_up.nil? && returned.nil?
    return :active if picked_up.present? && returned.nil?
    return :returned if picked_up.present? && returned.present?
  end


  def problem
    case status
    when :reserved
      return :late_pickup if pickup_at < DateTime.now
      return false
    when :active
      return :overdue if return_at < DateTime.now
      return false
    when :returned
      return :late_return if returned > return_at
      return false
    else
      return false
    end
  end


end
