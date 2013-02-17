# spec/models/thing_spec.rb
require 'spec_helper'

describe Thing do
  it "has a valid factory" do
    FactoryGirl.create(:thing).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:thing, name: nil).should_not be_valid
  end

  it "is invalid without a description" do
    FactoryGirl.build(:thing, description: nil).should_not be_valid
  end
end
