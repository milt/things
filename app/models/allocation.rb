class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout
  has_one :user, :through => :checkout
  attr_accessible :thing, :checkout, :picked_up, :returned
  validates :checkout, :thing, :presence => true
  delegate :pickup_at, :return_at, to: :checkout

  # @@possible_states = [:reserved,
  #           :active,
  #           :returned,
  #           :late_pickup,
  #           :overdue,
  #           :late_return
  #         ]

  # def self.create_status_finder(name)
  #   singleton_class.instance_eval do
  #     define_method(name) { return all.select {|a| a.status == name } }
  #   end
  # end

  # for state in @@possible_states
  #   create_status_finder(state)
  # end

  def self.reserved
    includes{checkout}.where{
      ((picked_up.eq nil) & (returned.eq nil)) &
      (checkout.pickup_at >= DateTime.now)
    }
  end

  def self.late_pickup
    includes{checkout}.where{
      ((picked_up.eq nil) & (returned.eq nil)) &
      (checkout.pickup_at < DateTime.now)
    }
  end

  def self.active
    includes{checkout}.where{
      ((picked_up.not_eq nil) & (returned.eq nil)) &
      (checkout.return_at >= DateTime.now)
    }
  end

  def self.overdue
    includes{checkout}.where{
      ((picked_up.not_eq nil) & (returned.eq nil)) &
      (checkout.return_at < DateTime.now)
    }
  end

  def self.returned
    includes{checkout}.where{
      ((picked_up.not_eq nil) & (returned.not_eq nil)) & (returned <= checkout.return_at)
    }
  end

  def self.late_return
    includes{checkout}.where{
      ((picked_up.not_eq nil) & (returned.not_eq nil)) & (returned > checkout.return_at)
    }
  end


  def self.find_for_range(b,e)
    joins{:checkout}.where{
                            ((checkout.pickup_at < b) & (checkout.return_at > e)) |
                            ((checkout.pickup_at >= b) & (checkout.return_at <= e)) |
                            ((checkout.pickup_at < b) & (checkout.return_at <= e) & (checkout.return_at >= b)) |
                            ((checkout.pickup_at >= b) & (checkout.pickup_at <= e) & (checkout.return_at > e)) |
                            (
                              ((checkout.pickup_at < b) & (checkout.return_at < b)) &
                              (picked_up.present? & returned.nil?)
                            )
                          }
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