class AttendeeSynchronizer
  def initialize(event)
    @event = event
  end

  def sync
    eventbrite_attendees.each do |eb_attendee|
      next unless eb_attendee[:checked_in]
      next unless TICKET_CLASS_NAMES.include?(eb_attendee[:ticket_class_name])

      attendee = Attendee.find_or_initialize_by(event_id: event.id, eventbrite_id: eb_attendee[:id])
      attendee.email = eb_attendee[:profile][:email]
      attendee.name = eb_attendee[:profile][:name]
      if eb_attendee[:answers].present?
        discord_answer = eb_attendee[:answers].detect { |a| a[:question] == DISCORD_NAME_QUESTION }
        attendee.discord_name = discord_answer[:answer]
      end
      attendee.save!
    end
  end

  private

  TICKET_CLASS_NAMES = [
    "Free Tickets",
    "GA Extras",
    "General Admission",
  ].freeze

  DISCORD_NAME_QUESTION = "Discord name".freeze

  def eventbrite_attendees
    @eventbrite_attendees ||= Eventbrite.new.attendees(event.eventbrite_id)
  end

  attr_accessor :event
end
