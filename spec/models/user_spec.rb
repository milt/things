require "cancan/matchers"

describe "User" do

  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is guest" do
      let(:user){ User.new }

      it{ should be_able_to(:read, Thing) }
      it{ should_not be_able_to(:read, [User,Role,Ability]) }
    end

    context "when is an admin" do
      let(:user){ FactoryGirl.create(:admin) }

      it{ should be_able_to(:manage, :all) }
    end

    context "when is an operator" do
      let(:user){ FactoryGirl.create(:operator) }

      it{ should be_able_to(:read, :all)}
      it{ should be_able_to(:manage, Checkout) }
    end

    context "when is a patron" do
      let(:user){ FactoryGirl.create(:patron) }

      it{ should be_able_to(:read, Thing) }
      it{ should be_able_to(:reserve, Checkout) }
    end
  end
end