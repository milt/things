require 'spec_helper'

describe Allocation do
  it "is invalid without a checkout" do
    allocation = FactoryGirl.build(:allocation, checkout: nil)
    allocation.checkout = nil
    allocation.should_not be_valid
  end

  it "is invalid without a thing" do
    FactoryGirl.build(:allocation, thing: nil).should_not be_valid
  end

  context "when it is created" do
    it "is invalid if thing is reserved between pickup_at and return_at" do
      prior_checkout = FactoryGirl.create(:reservation_checkout)

      thing = prior_checkout.things.first

      checkout = FactoryGirl.build(:checkout, pickup_at: prior_checkout.pickup_at, return_at: prior_checkout.return_at)
      allocation = checkout.allocations.build(thing: thing)
      allocation.should_not be_valid
    end
  end
  context "when it is picked up" do
    it "is invalid if the pickup time is not within the pickup and return times of the checkout" do
      checkout = FactoryGirl.create(:reservation_checkout)
      allocation = checkout.allocations.first
      allocation.pickup
      allocation.should_not be_valid
    end

    it "is invalid if thing is overdue and has not been returned" do
      prior_checkout = FactoryGirl.create(:overdue_checkout)

      thing = prior_checkout.things.first

      checkout = FactoryGirl.build(:checkout)
      allocation = checkout.allocations.build(thing: thing)
      allocation.should_not be_valid
    end
  end
end
