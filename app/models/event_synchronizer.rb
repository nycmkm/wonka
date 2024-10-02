class EventSynchronizer
  def sync
    external_events.each do |ex_event|
      event = Event.find_or_initialize_by(external_event_id: ex_event[:slug])
      event.name = ex_event[:title]
      event.date = Time.zone.parse("#{ex_event[:start_date]} #{ex_event[:start_time]}")
      event.save!
    end
  end

  private

  def external_events
    Tito.new.events
  end
end
