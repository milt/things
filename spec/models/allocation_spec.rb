require 'spec_helper'

describe Allocation do
  it "is invalid without a checkout" do
    FactoryGirl.build(:allocation, checkout: nil).should_not be_valid
  end

  it "is invalid without a thing" do
    FactoryGirl.build(:allocation, thing: nil).should_not be_valid
  end

  it "is invalid if thing is reserved between pickup_at and return_at" do
    pending
  end

  it "cannot be picked up if it is still out on an overdue allocation" do
    pending
  end

end
