def create_user
  @user = FactoryGirl.create(:user)
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @user[:email]
  fill_in "user_password", :with => @user[:password]
  click_button "Sign in"
end

def create_admin
  create_user
  @user.add_role :admin
end

### GIVEN ###

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I am an admin$/ do
  create_admin
end

