# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do
    user
    pickup_at DateTime.now
    return_at DateTime.now + 1.day
    after(:create) do |checkout|
      Array(1..10).sample.times.map do
        FactoryGirl.create(:allocation, checkout: checkout)
      end
    end
  end
end

