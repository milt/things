class Allocation < ActiveRecord::Base
  belongs_to :thing
  belongs_to :checkout, inverse_of: :allocations
  has_one :user, through: :checkout
  #attr_accessible :picked_up, :returned, :thing
  validates :thing, :checkout, presence: true
  delegate :pickup_at, :return_at, to: :checkout
  validate :cannot_reserve_if_conflict, unless: Proc.new {|a| a.thing.blank? || a.checkout.blank? }
  # validate :cannot_pickup_if_out

  def cannot_reserve_if_conflict
    conflicts = find_conflicts
    if conflicts
      conflicts.keys.each do |status|
        conflicts[status].each do |allocation|
          errors.add(:base, "Conflicts with #{status.to_s} allocation #{allocation.id.to_s} from checkout #{allocation.checkout_id.to_s}")
        end
      end
    end
  end


  def self.reserved
    where( "picked_up IS NULL AND returned IS NULL" ).joins(:checkout).where("pickup_at >= ?", DateTime.now)
  end

  def self.late_pickup
    where( "picked_up IS NULL AND returned IS NULL" ).joins(:checkout).where("pickup_at < ?", DateTime.now)
  end

  def self.active
    where( "picked_up IS NOT NULL AND returned IS NULL" ).joins(:checkout).where("return_at >= ?", DateTime.now)
  end

  def self.overdue
    where( "picked_up IS NOT NULL AND returned IS NULL" ).joins(:checkout).where("return_at < ?", DateTime.now)
  end

  def self.returned
    where( "picked_up IS NOT NULL AND returned IS NOT NULL" ).joins(:checkout).where("return_at <= returned")
  end

  def self.late_return
    where( "picked_up IS NOT NULL AND returned IS NOT NULL" ).joins(:checkout).where("return_at < returned")
  end

  def self.find_for_range(b,e)
    joins(:checkout).where("pickup_at <= ? AND return_at >= ?", e, b)
  end

  def find_conflicts

    conflicts = thing.allocations.find_for_range(pickup_at,return_at).where.not(id: id)
    if pickup_at <= DateTime.now + 1.hour #TODO: make this a pref
      conflicts += thing.allocations.overdue
    end

    if conflicts.empty?
      return false
    else
      return conflicts.group_by(&:status)
    end
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

  def pickup
    self.picked_up = DateTime.now
  end
end