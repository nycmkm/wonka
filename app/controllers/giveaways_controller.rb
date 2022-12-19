class GiveawaysController < ApplicationController
  before_action :set_giveaway, only: %i[ show edit update destroy ]

  # GET /giveaways or /giveaways.json
  def index
    @giveaways = Giveaway.all
  end

  # GET /giveaways/1 or /giveaways/1.json
  def show
  end

  # GET /giveaways/new
  def new
    @giveaway = Giveaway.new
  end

  # GET /giveaways/1/edit
  def edit
  end

  # POST /giveaways or /giveaways.json
  def create
    @giveaway = Giveaway.new(giveaway_params)

    respond_to do |format|
      if @giveaway.save
        format.html { redirect_to giveaway_url(@giveaway), notice: "Giveaway was successfully created." }
        format.json { render :show, status: :created, location: @giveaway }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /giveaways/1 or /giveaways/1.json
  def update
    respond_to do |format|
      if @giveaway.update(giveaway_params)
        format.html { redirect_to giveaway_url(@giveaway), notice: "Giveaway was successfully updated." }
        format.json { render :show, status: :ok, location: @giveaway }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /giveaways/1 or /giveaways/1.json
  def destroy
    @giveaway.destroy

    respond_to do |format|
      format.html { redirect_to giveaways_url, notice: "Giveaway was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_giveaway
      @giveaway = Giveaway.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def giveaway_params
      params.require(:giveaway).permit(:name, :event_id)
    end
end
