class TimmingsController < ApplicationController
  before_action :set_timming, only: [:show, :edit, :update, :destroy]

  # GET /timmings
  # GET /timmings.json
  def index
    @timmings = Timming.all
  end

  # GET /timmings/1
  # GET /timmings/1.json
  def show
  end

  # GET /timmings/new
  def new
    @timming = Timming.new
  end

  # GET /timmings/1/edit
  def edit
  end

  # POST /timmings
  # POST /timmings.json
  def create
    @timming = Timming.new(timming_params)

    respond_to do |format|
      if @timming.save
        format.html { redirect_to @timming, notice: 'Timming was successfully created.' }
        format.json { render :show, status: :created, location: @timming }
      else
        format.html { render :new }
        format.json { render json: @timming.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timmings/1
  # PATCH/PUT /timmings/1.json
  def update
    respond_to do |format|
      if @timming.update(timming_params)
        format.html { redirect_to @timming, notice: 'Timming was successfully updated.' }
        format.json { render :show, status: :ok, location: @timming }
      else
        format.html { render :edit }
        format.json { render json: @timming.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timmings/1
  # DELETE /timmings/1.json
  def destroy
    @timming.destroy
    respond_to do |format|
      format.html { redirect_to timmings_url, notice: 'Timming was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timming
      @timming = Timming.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timming_params
      params.require(:timming).permit(:in, :bus_type, :provider)
    end
end
