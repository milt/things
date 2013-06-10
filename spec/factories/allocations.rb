# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :allocation do
    #checkout
    thing
    picked_up nil
    returned nil

    after(:build) do |allocation|
      if allocation.checkout.nil?
        checkout = FactoryGirl.build(:checkout)
        checkout.allocations.clear
        checkout.allocations << allocation
      end
    end
  end
end
