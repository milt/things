# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do
    user

    factory :reservation do
      Array(1..10).sample.times.map do
        FactoryGirl.create(:reservation_alloc, checkout: checkout)
      end
    end

    factory :late_pickup do
      Array(1..10).sample.times.map do
        FactoryGirl.create(:late_pickup_alloc, checkout: checkout)
      end
    end

    factory :active do
      Array(1..10).sample.times.map do
        FactoryGirl.create(:active_alloc, checkout: checkout)
      end
    end

    factory :overdue do
      Array(1..10).sample.times.map do
        FactoryGirl.create(:overdue_alloc, checkout: checkout)
      end
    end

    factory :returned do
      Array(1..10).sample.times.map do
        FactoryGirl.create(:returned_alloc, checkout: checkout)
      end
    end

    factory :late_return do
      Array(1..10).sample.times.map do
        FactoryGirl.create(:late_return_alloc, checkout: checkout)
      end
    end
  end
end

