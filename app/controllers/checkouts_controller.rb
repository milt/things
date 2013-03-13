class CheckoutsController < ApplicationController
  load_and_authorize_resource
  # GET /checkouts
  # GET /checkouts.json
  def index
    @checkouts = Checkout.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkouts }
    end
  end

  # GET /checkouts/1
  # GET /checkouts/1.json
  def show
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkout }
    end
  end

  # GET /checkouts/new
  # GET /checkouts/new.json
  def new
    @typeahead_names = Thing.pluck(:name)
    @checkout = Checkout.new

    unless session[:selected_thing_ids]
      session[:selected_thing_ids] = []
    end

    if params[:add_thing_id]
      session[:selected_thing_ids] << params[:add_thing_id]
    end

    if params[:remove_thing_id]
      session[:selected_thing_ids].reject! {|e| e == params[:remove_thing_id]}
    end

    if session[:selected_thing_ids]
      @selected_things = Thing.find(session[:selected_thing_ids])
    end

    @q = Thing.search(params[:q])
    result = @q.result(distinct: true)
    @things = @q.result(:distinct => true).page(params[:page]).per(5)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkout }
      format.js
    end
  end

  # GET /checkouts/1/edit
  def edit
    @checkout = Checkout.find(params[:id])
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new(params[:checkout])
    @checkout.user = current_user
    @checkout.add_things(params[:thing_ids])

    @q = Thing.search(params[:q])
    @things = @q.result(:distinct => true).page(params[:page]).per(5)

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to @checkout, notice: 'Checkout was successfully created.' }
        format.json { render json: @checkout, status: :created, location: @checkout }
      else
        format.html { render action: "new" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.json
  def update
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      if @checkout.update_attributes(params[:checkout])
        format.html { redirect_to @checkout, notice: 'Checkout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.json
  def destroy
    @checkout = Checkout.find(params[:id])
    @checkout.destroy

    respond_to do |format|
      format.html { redirect_to checkouts_url }
      format.json { head :no_content }
    end
  end
end
