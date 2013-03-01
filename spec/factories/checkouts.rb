# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do
    user

    factory :reservation_checkout do
      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:reservation_alloc, checkout: checkout)
        end
      end
    end

    factory :late_pickup_checkout do
      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:late_pickup_alloc, checkout: checkout)
        end
      end
    end

    factory :active_checkout do
      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:active_alloc, checkout: checkout)
        end
      end
    end

    factory :overdue_checkout do
      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:overdue_alloc, checkout: checkout)
        end
      end
    end

    factory :returned_checkout do
      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:returned_alloc, checkout: checkout)
        end
      end
    end

    factory :late_return_checkout do
      after(:create) do |checkout|
        Array(1..10).sample.times.map do
          FactoryGirl.create(:late_return_alloc, checkout: checkout)
        end
      end
    end
  end
end

