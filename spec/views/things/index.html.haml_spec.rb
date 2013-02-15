require 'spec_helper'

describe "things/index" do
  before(:each) do
    assign(:things, [
      stub_model(Thing,
        :index => "Index",
        :edit => "Edit",
        :new => "New",
        :show => "Show"
      ),
      stub_model(Thing,
        :index => "Index",
        :edit => "Edit",
        :new => "New",
        :show => "Show"
      )
    ])
  end

  it "renders a list of things" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Index".to_s, :count => 2
    assert_select "tr>td", :text => "Edit".to_s, :count => 2
    assert_select "tr>td", :text => "New".to_s, :count => 2
    assert_select "tr>td", :text => "Show".to_s, :count => 2
  end
end
