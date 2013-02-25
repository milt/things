require 'spec_helper'

describe Allocation do
  it "is invalid without a checkout" do
    FactoryGirl.build(:allocation, checkout: nil).should_not be_valid
  end

  it "is invalid without a thing" do
    FactoryGirl.build(:allocation, thing: nil).should_not be_valid
  end

  it "is invalid without a pickup time" do
    FactoryGirl.build(:allocation, pickup_at: nil).should_not be_valid
  end

  it "is invalid without a return time" do
    FactoryGirl.build(:allocation, return_at: nil).should_not be_valid
  end

end
