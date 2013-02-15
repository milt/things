require 'spec_helper'

describe "things/new" do
  before(:each) do
    assign(:thing, stub_model(Thing,
      :index => "MyString",
      :edit => "MyString",
      :new => "MyString",
      :show => "MyString"
    ).as_new_record)
  end

  it "renders new thing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => things_path, :method => "post" do
      assert_select "input#thing_index", :name => "thing[index]"
      assert_select "input#thing_edit", :name => "thing[edit]"
      assert_select "input#thing_new", :name => "thing[new]"
      assert_select "input#thing_show", :name => "thing[show]"
    end
  end
end
