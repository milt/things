# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :allocation do
    checkout nil
    thing
    pickup_at nil
    return_at nil
    picked_up nil
    returned nil
  end
end
