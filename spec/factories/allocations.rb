# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :allocation do
    checkout
    thing
    picked_up nil
    returned nil
  end
end
