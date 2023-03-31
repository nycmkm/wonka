class AttendeeSynchronizer
  def initialize(event)
    @event = event
  end

  def sync
    eventbrite_attendees.each do |eb_attendee|
      next unless eb_attendee[:checked_in]
      # TODO: Make an actual match against ticket_class_id
      next if eb_attendee[:ticket_class_name].starts_with?("Meetup T-Shirt")

      attendee = Attendee.find_or_initialize_by(event_id: event.id, eventbrite_id: eb_attendee[:id])
      attendee.email = eb_attendee[:profile][:email]
      attendee.name = eb_attendee[:profile][:name]
      attendee.save!
    end
  end

  private

  def eventbrite_attendees
    @eventbrite_attendees ||= Eventbrite.new.attendees(event.eventbrite_id)
  end

  attr_accessor :event
end
