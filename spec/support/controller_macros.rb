module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
    end
  end

  def login_operator
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:operator]
      sign_in FactoryGirl.create(:operator)
    end
  end

  def login_patron
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:patron]
      sign_in FactoryGirl.create(:patron)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
    end
  end
end
