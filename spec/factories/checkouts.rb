# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do
    user
    pickup_at DateTime.now
    return_at DateTime.now + 1.day
    allocations {
      Array(1..10).sample.times.map do
        FactoryGirl.build(:allocation)
      end
    }
    after(:create) {|checkout| checkout.allocations.each {|a| a.save}}
  end
end
