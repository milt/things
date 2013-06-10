# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do #checkout w/no allocations
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

      after(:build) do |checkout|
        things = Array(1..10).sample.times.map {FactoryGirl.create(:thing)}
        checkout.add_things(things)
      end
    end

    factory :active_checkout do #active checkout, out 1 day, 1 day til return
      pickup_at DateTime.now - 1.day
      return_at DateTime.now + 1.day

      factory :overdue_checkout do #problem: patron is late for return.
        pickup_at DateTime.now - 1.day
        return_at DateTime.now - 30.minutes
      end

      after(:build) do |checkout|
        things = Array(1..10).sample.times.map {FactoryGirl.create(:thing)}
        checkout.add_things(things)

        checkout.allocations.each do |a|
          a.picked_up = checkout.pickup_at
        end
      end
    end

    factory :returned_checkout do #checkout returned 1 day ago
      pickup_at DateTime.now - 2.days
      return_at DateTime.now - 1.days

      factory :late_return_checkout do #problem: patron returned the item late!
        pickup_at DateTime.now - 2.days
        return_at DateTime.now - 1.day

        after(:build) do |checkout|
          things = Array(1..10).sample.times.map {FactoryGirl.create(:thing)}
          checkout.add_things(things)
          checkout.allocations.each do |a|
            a.picked_up = checkout.pickup_at
            a.returned = checkout.return_at + 1.hour
          end
        end
      end
    end

    after(:build) do |checkout|
      if checkout.allocations.empty?
        things = Array(1..10).sample.times.map {FactoryGirl.create(:thing)}
        checkout.add_things(things)
        checkout.allocations.each {|a| a.pickup }
      end
    end
  end
end

