def create_anything
  @anything ||= { :name => "raygun",
    :description => "Shoots stuff" }
end

def delete_thing
  @thing ||= Thing.where(:name => @anything[:name]).first
  @thing.destroy unless @thing.nil?
end


def build_valid_thing
  create_anything
  delete_thing
  @thing = FactoryGirl.build(:thing, @anything)
end

def build_invalid_thing
  create_anything
  delete_thing
  @thing = FactoryGirl.build(:thing, @anything)
  @thing.name = nil
end


def add_new
  click_link 'New Thing'
  fill_in 'Name', :with => @thing[:name]
  fill_in 'Description', :with => @thing[:description]
  click_button "Save"
end

def edit
  visit edit_thing_path(@thing)
  fill_in 'Name', :with => @thing[:name]
  fill_in 'Description', :with => @thing[:description]
  click_button "Save"
end

def add_some_things
  3.times do
    FactoryGirl.create(:thing)
  end
end

Given /^I am at the things index page$/ do
  visit '/things'
  page.should have_content "Things"
end

Given /^that there are things in the database$/ do
  add_some_things
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

Then /^I should see a confirmation message that it was created$/ do
  page.should have_content "Thing was successfully created."
end

Then /^I should be returned to the new page$/ do
  page.should have_content "New Thing"
end

Then /^I should see a description validation error$/ do
  page.should have_content "can't be blank"
end


When /^I view a thing$/ do
  build_valid_thing
  @thing.save
  visit thing_path(@thing)
end

Then /^I should see all of its attributes$/ do
  page.should have_content @thing.id.to_s
  page.should have_content @thing.name
  page.should have_content @thing.description
end

Then /^I should be able to edit it$/ do
  page.should have_link "Edit"
end

Then /^I should be able to go back$/ do
  page.should have_link "Back"
end

When /^I edit a thing with valid parameters$/ do
  build_valid_thing
  @thing.save
  @thing.description += "morestuff"
  edit
end

When /^I edit a thing with invalid parameters$/ do
  build_valid_thing
  @thing.save
  @thing.name = nil
  edit
end

Then /^I should see a confirmation message that it was edited$/ do
  page.should have_content "Thing was successfully updated."
end

Then /^I should be returned to the edit page$/ do
  page.should have_content "Editing thing"
end

Then /^I should see a validation error$/ do
  page.should have_content "can't be blank"
end

When /^I delete a thing$/ do
  pending # need to figure out how to get selenium to work with the popup conf
end

Then /^I should be redirected to the index$/ do
  page.should have_content "Things"
end

When /^I type in the search box$/ do
  fill_in "search", :with => Thing.first.name
end

Then /^I should see results below$/ do
  page.should have_content Thing.first.name # replace for ajax stuff
end
