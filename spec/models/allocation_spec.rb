require 'spec_helper'

describe Allocation do
  it "is invalid without a checkout" do
    FactoryGirl.build(:allocation, checkout: nil).should_not be_valid
  end

  it "is invalid without a thing" do
    FactoryGirl.build(:allocation, thing: nil).should_not be_valid
  end

  context "when it is created" do
    it "is invalid if thing is reserved between pickup_at and return_at" do
      pending
    end
  end
  context "when it is picked up" do
    it "is invalid if thing is overdue and has not been returned" do
      pending
    end
  end
end
