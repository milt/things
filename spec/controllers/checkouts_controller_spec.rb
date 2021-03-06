require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CheckoutsController do
  login_operator

  # This should return the minimal set of attributes required to create a valid
  # Checkout. As you add validations to Checkout, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    #user = FactoryGirl.create(:patron)
    patron = User.first
    things = 10.times.map {FactoryGirl.create(:thing)}

    attrs = {checkout: {return_at: DateTime.now + 3.day}, thing_ids: things.map(&:id)}
    #attrs[:user_id] = user.id #temp, modify controller to really handle user
    return attrs
  end

  def invalid_attributes
    attrs = valid_attributes
    attrs[:checkout][:return_at] = ""
    return attrs
  end
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CheckoutsController. Be sure to keep this updated too.
  # def valid_session
  #   {}
  # end

  describe "GET index" do
    it "assigns all checkouts as @checkouts" do
      checkout = FactoryGirl.create(:checkout)
      get :index, {}
      assigns(:checkouts).should eq([checkout])
    end
  end

  describe "GET show" do
    it "assigns the requested checkout as @checkout" do
      checkout = FactoryGirl.create(:checkout)
      get :show, {:id => checkout.to_param}
      assigns(:checkout).should eq(checkout)
    end
  end

  describe "GET new" do
    it "assigns a new checkout as @checkout" do
      get :new, {}
      assigns(:checkout).should be_a_new(Checkout)
    end
  end

  describe "GET edit" do
    it "assigns the requested checkout as @checkout" do
      checkout = FactoryGirl.create(:checkout)
      get :edit, {:id => checkout.to_param}
      assigns(:checkout).should eq(checkout)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Checkout" do
        expect {
          post :create, valid_attributes
        }.to change(Checkout, :count).by(1)
      end

      it "assigns a newly created checkout as @checkout" do
        post :create, valid_attributes
        assigns(:checkout).should be_a(Checkout)
        assigns(:checkout).should be_persisted
      end

      it "redirects to the created checkout" do
        post :create, valid_attributes
        response.should redirect_to(Checkout.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved checkout as @checkout" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checkout.any_instance.stub(:save).and_return(false)
        post :create, invalid_attributes
        assigns(:checkout).should be_a_new(Checkout)
      end

      it "redirects to new" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checkout.any_instance.stub(:save).and_return(false)
        post :create, invalid_attributes
        response.should be_redirect
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested checkout" do
        checkout = FactoryGirl.create(:reservation_checkout)
        # Assuming there are no other checkouts in the database, this
        # specifies that the Checkout created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        test_params = { "return_at" => (DateTime.now + 3.days).to_s }
        Checkout.any_instance.should_receive(:update_attributes).with(test_params)
        put :update, {:id => checkout.to_param, :checkout => test_params}
      end

      it "assigns the requested checkout as @checkout" do
        checkout = FactoryGirl.create(:checkout)
        put :update, {:id => checkout.to_param, :checkout => valid_attributes[:checkout]}
        assigns(:checkout).should eq(checkout)
      end

      it "redirects to the checkout" do
        checkout = FactoryGirl.create(:checkout)
        put :update, {:id => checkout.to_param, :checkout => valid_attributes[:checkout]}
        response.should redirect_to(checkout)
      end
    end

    describe "with invalid params" do
      it "assigns the checkout as @checkout" do
        checkout = FactoryGirl.create(:checkout)
        # Trigger the behavior that occurs when invalid params are submitted
        Checkout.any_instance.stub(:save).and_return(false)
        put :update, {:id => checkout.to_param, :checkout => invalid_attributes[:checkout]}
        assigns(:checkout).should eq(checkout)
      end

      it "re-renders the 'edit' template" do
        checkout = FactoryGirl.create(:checkout)
        # Trigger the behavior that occurs when invalid params are submitted
        Checkout.any_instance.stub(:save).and_return(false)
        put :update, {:id => checkout.to_param, :checkout => invalid_attributes[:checkout]}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested checkout" do
      checkout = FactoryGirl.create(:checkout)
      expect {
        delete :destroy, {:id => checkout.to_param}
      }.to change(Checkout, :count).by(-1)
    end

    it "redirects to the checkouts list" do
      checkout = FactoryGirl.create(:checkout)
      delete :destroy, {:id => checkout.to_param}
      response.should redirect_to(checkouts_url)
    end
  end

end
