class AttendeeSynchronizer
  def initialize(event)
    @event = event
  end

  def sync
    event = find_or_create_event
    find_or_create_attendees
  end

  private

  def eventbrite_attendees
    @eventbrite_attendees ||= Eventbrite.new.attendees(event.
  end

  attr_accessor :event
end
