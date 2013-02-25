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


#testing status

  context "when is a reservation" do
    let(:checkout){ FactoryGirl.create(:reservation) }

    it "should return reservation as status" do
      checkout.status.should eq(:reservation)
    end

    it "should show up in the reservation scope" do
      Checkout.reservation.should include(checkout)
    end
  end

  # context "when is late for pickup" do
  #   let(:checkout){ FactoryGirl.create(:late_for_pickup) }

  #   it "should return late_for_pickup as status" do
  #     checkout.status.should eq(:late_for_pickup)
  #   end

  #   it "should show up in the late_for_pickup scope" do
  #     Checkout.late_for_pickup.should include(checkout)
  #   end
  # end

  context "when is active" do
    let(:checkout){ FactoryGirl.create(:active) }

    it "should return active as status" do
      checkout.status.should eq(:active)
    end

    it "should show up in the active scope" do
      Checkout.active.should include(checkout)
    end
  end

  # context "when is overdue" do
  #   let(:checkout){ FactoryGirl.create(:overdue) }

  #   it "should return overdue as status" do
  #     checkout.status.should eq(:overdue)
  #   end

  #   it "should show up in the overdue scope" do
  #     Checkout.overdue.should include(checkout)
  #   end
  # end

  context "when has been returned" do
    let(:checkout){ FactoryGirl.create(:returned) }

    it "should return returned as status" do
      checkout.status.should eq(:returned)
    end

    it "should show up in the returned scope" do
      Checkout.returned.should include(checkout)
    end
  end

  # context "when has been returned late" do
  #   let(:checkout){ FactoryGirl.create(:late_return) }

  #   it "should return late return as status" do
  #     checkout.status.should eq(:late_return)
  #   end

  #   it "should show up in the returned_late scope" do
  #     Checkout.returned_late.should include(checkout)
  #   end
  # end


  # context "when is returned late" do
  # end

  # context "when is picked up late" do
  # end
end
