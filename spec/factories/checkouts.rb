# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checkout do
    user FactoryGirl.create(:user)
    pickup_at DateTime.now
    return_at DateTime.now + 1.day
    3.times do
      allocations << FactoryGirl.create(:allocation, {:thing => FactoryGirl.create(:thing)})
    end
  end
end
