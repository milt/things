# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :allocation do
    checkout nil
    thing
    pickup_at DateTime.now
    return_at DateTime.now + 1.day
    picked_up DateTime.now
    returned nil

    factory :reservation_alloc do
      pickup_at DateTime.now + 1.day
      return_at DateTime.now + 2.days
      picked_up nil
      returned nil

      factory :late_pickup_alloc do
        pickup_at DateTime.now - 1.hour
        return_at DateTime.now + 1.day
      end
    end

    factory :active_alloc do
      pickup_at DateTime.now - 1.day
      return_at DateTime.now + 1.day
      picked_up DateTime.now - 1.day
      returned nil

      factory :overdue_alloc do
        pickup_at DateTime.now - 2.days
        return_at DateTime.now - 1.days
        picked_up DateTime.now - 2.days
      end
    end

    factory :returned_alloc do
      pickup_at DateTime.now - 2.days
      return_at DateTime.now - 1.days
      picked_up DateTime.now - 2.days
      returned DateTime.now - 1.days

      factory :late_return_alloc do
        returned DateTime.now - 1.days + 15.minutes
      end
    end
  end
end
