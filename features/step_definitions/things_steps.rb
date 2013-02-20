def build_valid_thing
	@thing = FactoryGirl.build(:thing)
end

def build_invalid_thing
	@thing = FactoryGirl.build(:thing, name: nil)
end

def add_new
  visit '/things/new'
  puts page.body
  fill_in 'thing_name', :with => @thing[:name]
  fill_in 'thing_description', :with => @thing[:description]
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

Then /^I should be returned to the index$/ do
  page.should_have_content "Things"
end

Then /^I should see a confirmation message$/ do
  page.should_have_content "Thing was successfully created."
end

Then /^I should be returned to the new page$/ do
  page.should_have_content "New Thing"
end

Then /^I should see a description validation error$/ do
  pending # express the regexp above with the code you wish you had
end