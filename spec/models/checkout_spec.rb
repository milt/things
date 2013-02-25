require 'spec_helper'

describe Checkout do
  it "has a valid factory" do
    FactoryGirl.create(:checkout).should be_valid
  end

  it "is invalid without a user" do
    FactoryGirl.build(:checkout, user: nil).should_not be_valid
  end

  it "is invalid without a pickup time" do
    FactoryGirl.build(:checkout, pickup_at: nil).should_not be_valid
  end

  it "is invalid without a return time" do
    FactoryGirl.build(:checkout, return_at: nil).should_not be_valid
  end

  it "should get rid of its allocations if it is deleted" do
    checkout = FactoryGirl.create(:checkout)
    checkout.destroy
    Allocation.where("checkout_id",checkout.id).should be_empty
  end


  #pending "add some examples to (or delete) #{__FILE__}"
end
