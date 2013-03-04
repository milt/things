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

    @@possible_states = [:reserved,
              :active,
              :returned,
              :late_pickup,
              :overdue,
              :late_return
            ]

  def self.create_status_finder(name)
    singleton_class.instance_eval do
      define_method(name) { return all.select {|a| a.status == name } }
    end
  end

  for state in @@possible_states
    create_status_finder(state)
  end

  def status
    if picked_up.nil? && returned.nil?
      if pickup_at < DateTime.now
        return :late_pickup
      else
        return :reserved
      end
    end
    if picked_up.present? && returned.nil?
      if return_at < DateTime.now
        return :overdue
      else
        return :active
      end
    end
    if picked_up.present? && returned.present?
      if return_at < returned
        return :late_return
      else
        return :returned
      end
    end
  end

  def problem?
    case status
    when :reserved, :active, :returned
      return false
    else
      return status
    end
  end
end