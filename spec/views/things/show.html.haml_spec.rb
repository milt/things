require 'spec_helper'

describe "things/show" do
  before(:each) do
    @thing = assign(:thing, stub_model(Thing,
      :index => "Index",
      :edit => "Edit",
      :new => "New",
      :show => "Show"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Index/)
    rendered.should match(/Edit/)
    rendered.should match(/New/)
    rendered.should match(/Show/)
  end
end
