def create_anything
  @anything ||= { :name => "raygun",
    :description => "Shoots stuff" }
end

def delete_thing
  @thing ||= Thing.where(:name => @anything[:name]).first
  @thing.destroy unless @thing.nil?
end


def create_thing
  create_anything
  delete_thing
  @thing = FactoryGirl.build(:thing, @anything)
end

def create_invalid_thing
  create_anything
  delete_thing
  @thing = FactoryGirl.build(:thing, @anything)
  @thing.name = nil
end

def build_valid_thing
  create_anything
  delete_thing
	create_thing
end

def build_invalid_thing
  create_anything
  delete_thing
  create_invalid_thing
end

def add_new
  visit '/things/new'
  fill_in 'Name', :with => @thing[:name]
  fill_in 'Description', :with => @thing[:description]
  click_button "Save"
end

When /^I add a new thing with valid parameters$/ do
  build_valid_thing
  add_new
end

When /^I add a new thing with invalid parameters$/ do
  build_invalid_thing
  add_new
end

Then /^I should be redirected to the thing$/ do
  page.should have_content "Thing #" # need to get the code to find the action/path
end

Then /^I should see a confirmation message$/ do
  page.should have_content "Thing was successfully created."
end

Then /^I should be returned to the new page$/ do
  page.should have_content "New Thing"
end

Then /^I should see a description validation error$/ do
  page.should have_content "can't be blank"
end