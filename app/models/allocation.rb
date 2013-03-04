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

  def status(*args) #optionally, a hash of params for checkout can be passed in to reduce database calls
    options = args.extract_options!
    parent_pickup_at = options['pickup_at'] || pickup_at
    parent_return_at = options['return_at'] || return_at
    
    if picked_up.nil? && returned.nil?
      if parent_pickup_at < DateTime.now
        return :late_pickup
      else
        return :reserved
      end
    end
    if picked_up.present? && returned.nil?
      if parent_return_at < DateTime.now
        return :overdue
      else
        return :active
      end
    end
    if picked_up.present? && returned.present?
      if parent_return_at < returned
        return :late_return
      else
        return :returned
      end
    end
  end

  def problem?(*args)
    checkout_attrs = args.extract_options! || self.checkout.attributes
    case status(checkout_attrs)
    when :reserved, :active, :returned
      return false
    else
      return status(checkout_attrs)
    end
  end
end