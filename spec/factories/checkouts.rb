# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do
    user
    pickup_at DateTime.now
    return_at DateTime.now + 1.day
    picked_up DateTime.now
    returned nil

    factory :reservation do
      pickup_at DateTime.now + 1.day
      return_at DateTime.now + 2.days
      picked_up nil
      returned nil
    end

    factory :late_for_pickup do
      pickup_at DateTime.now - 1.hour
      return_at DateTime.now + 1.day
      picked_up nil
      returned nil
    end

    factory :active do
      pickup_at DateTime.now - 1.day
      return_at DateTime.now + 1.day
      picked_up DateTime.now - 1.day
      returned nil
    end

    factory :returned do
      pickup_at DateTime.now - 2.days
      return_at DateTime.now - 1.days
      picked_up DateTime.now - 2.days
      returned DateTime.now - 1.days
    end

    factory :overdue do
      pickup_at DateTime.now - 2.days
      return_at DateTime.now - 1.days
      picked_up DateTime.now - 2.days
      returned nil
    end

    factory :late_return do
      pickup_at DateTime.now - 2.days
      return_at DateTime.now - 1.days
      picked_up DateTime.now - 2.days
      returned DateTime.now - 1.days - 15.minutes
    end

    after(:create) do |checkout|
      Array(1..10).sample.times.map do
        FactoryGirl.create(:allocation, checkout: checkout, pickup_at: checkout.pickup_at, return_at: checkout.return_at)
      end
    end
  end
end

