class EventsController < ApplicationController
  def index
    @events = Event.all.order(date: :desc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def sync
    EventSynchronizer.new.sync

    redirect_back fallback_location: root_path, notice: "Synchronized Events"
  end
end
