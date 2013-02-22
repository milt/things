require 'spec_helper'

describe "Users" do
  describe "GET /users" do

    context "is a guest" do        
      it "should not be visible to guests" do
        get users_path
        response.status.should be(302)
      end
    end

  end
end
