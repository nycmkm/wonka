class EventsController < ApplicationController
  def sync
    EventSynchronizer.new.sync

    redirect_back fallback_location: root_path, notice: "Synchronized Events"
  end
end
