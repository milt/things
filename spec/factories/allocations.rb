# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :allocation do
    checkout nil
    thing
    pickup_at DateTime.now
    return_at DateTime.now + 1.day
  end
end
