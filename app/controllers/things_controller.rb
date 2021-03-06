class ThingsController < ApplicationController
  load_and_authorize_resource
  #autocomplete :thing, :name

  # GET /things
  # GET /things.json
  def index
    @q = Thing.search(params[:q])
    @things = @q.result(:distinct => true).page params[:page]
    @typeahead_names = Thing.pluck(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
      format.js
    end
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @thing = Thing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/new
  # GET /things/new.json
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = Thing.find(params[:id])
  end

  # POST /things
  # POST /things.json
  def create
    @thing = Thing.new(thing_params)

    respond_to do |format|
      if @thing.save
        format.html { redirect_to @thing, notice: 'Thing was successfully created.' }
        format.json { render json: @thing, status: :created, location: @thing }
      else
        format.html { render action: "new" }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.json
  def update
    @thing = Thing.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(thing_params)
        format.html { redirect_to @thing, notice: 'Thing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing = Thing.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to things_url, notice: 'Thing was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def thing_params
    params.require(:thing).permit(:name, :description)
  end
end
