require 'spec_helper'

describe "Checkouts" do
  describe "GET /checkouts" do
    context "is a guest" do        
      it "should not be visible to guests" do
        get checkouts_path
        response.status.should be(302)
      end
    end
  end
end
