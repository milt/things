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


  def status
    checkout_attrs = self.attributes
    allocations_statuses = (allocations.map {|a| a.status(checkout_attrs)}).uniq
    if allocations_statuses.count == 1
      return allocations_statuses.pop
    elsif allocations_statuses.count > 1
      complex_status = {}
      for allocation in allocations
        complex_status[allocation.status(checkout_attrs)] += [allocation]
      end
      return complex_status
    else
      return :no_allocations
    end
  end

  def problems?
    checkout_attrs = self.attributes
    problem_hash = {}
    for allocation in allocations
      problem_hash[allocation] = allocation.problem?(checkout_attrs) if allocation.problem?(checkout_attrs)
    end

    if problem_hash.empty?
      return false
    else
      return problem_hash
    end
  end
end
