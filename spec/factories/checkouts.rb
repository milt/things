# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do #a desk-style checkout, active immediately
    user
    pickup_at DateTime.now
    return_at DateTime.now + 1.day

    factory :reservation_checkout do
      pickup_at DateTime.now + 1.day
      return_at DateTime.now + 2.days

      factory :late_pickup_checkout do #problem: patron is late for pickup
        pickup_at DateTime.now - 30.minutes
        return_at DateTime.now + 1.day
      end

      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:allocation,
                              checkout: checkout,
                              pickup_at: checkout.pickup_at,
                              return_at: checkout.return_at
                              )
        end
      end
    end

    factory :active_checkout do #active checkout, out 1 day, 1 day til return
      pickup_at DateTime.now - 1.day
      return_at DateTime.now + 1.day

      factory :overdue_checkout do #problem: patron is late for return.
        pickup_at DateTime.now - 1.day
        return_at DateTime.now - 30.minutes
      end

      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:allocation,
                              checkout: checkout,
                              pickup_at: checkout.pickup_at,
                              return_at: checkout.return_at,
                              picked_up: checkout.pickup_at
                              )
        end
      end
    end

    factory :returned_checkout do #checkout returned 1 day ago
      pickup_at DateTime.now - 2.days
      return_at DateTime.now - 1.days

      factory :late_return_checkout do #problem: patron returned the item late!
        pickup_at DateTime.now - 2.days
        return_at DateTime.now - 1.day
      end

      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:allocation,
                              checkout: checkout,
                              pickup_at: checkout.pickup_at,
                              return_at: checkout.return_at,
                              picked_up: checkout.pickup_at,
                              returned: checkout.return_at + 1.hour
                              )
        end
      end
    end



    # only do this if allocs are not provided
    after(:create) do |checkout|
      if checkout.allocations.empty?
        Array(1..10).sample.times.map do
          FactoryGirl.create(:allocation,
                              checkout: checkout,
                              pickup_at: checkout.pickup_at,
                              return_at: checkout.return_at,
                              picked_up: checkout.pickup_at
                              )
        end
      end
    end
  end
end

