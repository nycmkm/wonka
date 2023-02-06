class EventSynchronizer
  def sync
    eventbrite_events.each do |eb_event|
      event = Event.find_or_initialize_by(eventbrite_id: eb_event[:id])

      event.name = eb_event[:name][:text]
      event.date = Time.zone.parse(eb_event[:start][:utc])
      event.save!
    end
  end

  private

  def eventbrite_events
    Eventbrite.new.events
  end
end
