# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :checkout do
    user
    allocations {
      Array(1..10).sample.times.map do
        FactoryGirl.create(:allocation)
      end
    }
  end
end
