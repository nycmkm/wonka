class EventsController < ApplicationController
  before_action :set_event, only: %i[show sync_attendees]

  def index
    @events = Event.order(date: :desc)
  end

  def show
    @open_giveaways = @event.giveaways.open
    @drawn_giveaways = @event.giveaways.drawn
    @attendees_without_wins = @event.attendees_without_wins
  end

  def sync
    EventSynchronizer.new.sync

    redirect_back fallback_location: root_path, notice: "Synchronized Events"
  end

  def sync_attendees
    AttendeeSynchronizer.new(@event).sync
    redirect_back fallback_location: root_path, notice: "Attendees synced"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
