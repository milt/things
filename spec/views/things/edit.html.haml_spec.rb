require 'spec_helper'

describe "things/edit" do
  before(:each) do
    @thing = assign(:thing, stub_model(Thing,
      :index => "MyString",
      :edit => "MyString",
      :new => "MyString",
      :show => "MyString"
    ))
  end

  it "renders the edit thing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => things_path(@thing), :method => "post" do
      assert_select "input#thing_index", :name => "thing[index]"
      assert_select "input#thing_edit", :name => "thing[edit]"
      assert_select "input#thing_new", :name => "thing[new]"
      assert_select "input#thing_show", :name => "thing[show]"
    end
  end
end
