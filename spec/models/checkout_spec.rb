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


#testing status, problems

  context "when is a reservation" do
    let(:checkout){ FactoryGirl.create(:reservation) }

    it "should return reservation as status" do
      checkout.status.should eq(:reservation)
    end

    it "should show up in the reservation scope" do
      Checkout.reservation.should include(checkout)
    end

    it "should not have a problem" do
      checkout.problem.should eq(false)
    end

    context "and is late for pickup" do
      let(:checkout){ FactoryGirl.create(:late_pickup) }

      it "should return late pickup as problem" do
        checkout.problem.should eq(:late_pickup)
      end

      it "should show up in the late pickup scope" do
        Checkout.late_pickup.should include(checkout)
      end
    end
  end

  context "when is active" do
    let(:checkout){ FactoryGirl.create(:active) }

    it "should return active as status" do
      checkout.status.should eq(:active)
    end

    it "should show up in the active scope" do
      Checkout.active.should include(checkout)
    end

    it "should not have a problem" do
      checkout.problem.should eq(false)
    end

    context "and is overdue" do
      let(:checkout){ FactoryGirl.create(:overdue) }

      it "should return overdue as problem" do
        checkout.problem.should eq(:overdue)
      end

      it "should show up in the overdue scope" do
        Checkout.overdue.should include(checkout)
      end
    end
  end

  context "when has been returned" do
    let(:checkout){ FactoryGirl.create(:returned) }

    it "should return returned as status" do
      checkout.status.should eq(:returned)
    end

    it "should show up in the returned scope" do
      Checkout.returned.should include(checkout)
    end

    it "should not have a problem" do
      checkout.problem.should eq(false)
    end

    context "and is a late return" do
      let(:checkout){ FactoryGirl.create(:late_return) }

      it "should return late_return as problem" do
        checkout.problem.should eq(:late_return)
      end

      it "should show up in the late return scope" do
        Checkout.late_return.should include(checkout)
      end
    end
  end
end
