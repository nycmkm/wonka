class GiveawaysController < ApplicationController
  before_action :set_giveaway, only: %i[show edit pick_winners update destroy]
  before_action :set_events, only: %i[new create edit update]

  def index
    @giveaways = Giveaway.order(:prize).group_by { |g| g.event.name }
  end

  def show; end

  def pick_winners
    GiveawayRoller.new(
      @giveaway,
      rerolls_params[:rerolls]&.compact_blank,
    ).roll
    redirect_to giveaway_url(@giveaway, animate: true), notice: "Winners have been picked!"
  end

  def new
    @giveaway = Giveaway.new
  end

  def edit; end

  def create
    @giveaway = Giveaway.new(giveaway_params)

    if @giveaway.save
      redirect_to giveaway_url(@giveaway), notice: "Giveaway was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @giveaway.update(giveaway_params)
      redirect_to giveaway_url(@giveaway), notice: "Giveaway was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @giveaway.destroy

    redirect_to giveaways_url, notice: "Giveaway was successfully destroyed."
  end

  private

  def set_events
    @events = Event.order(date: :desc)
  end

  def set_giveaway
    @giveaway = Giveaway.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def giveaway_params
    params.require(:giveaway).permit(:prize, :event_id, :num_winners, images: []).merge(user_id: current_user.id)
  end

  def rerolls_params
    params.fetch(:winners, {}).permit(rerolls: [])
  end
end
