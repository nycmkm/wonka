class AttendeeSynchronizer
  def initialize(event)
    @event = event
  end

  def sync
    external_attendees.each do |ex_attendee|
      attendee = Attendee.find_or_initialize_by(event_id: event.id, external_id: ex_attendee[:id])
      attendee.email = ex_attendee[:email]
      attendee.name = ex_attendee[:name]

      discord_question = ex_attendee[:questions].detect { |q| q[:title] = DISCORD_NAME_QUESTION }
      discord_question_id = discord_question && discord_question[:id]

      if ex_attendee[:answers].present?
        discord_answer = ex_attendee[:answers].detect { |a| a[:question_id] == discord_question_id }
        attendee.discord_name = discord_answer && discord_answer[:response]
      end

      next if attendee.email.blank? || attendee.name.blank?

      attendee.save!
    end
  end

  private

  DISCORD_NAME_QUESTION = "Discord name".freeze

  def external_attendees
    @external_attendees ||= Tito.new.attendees(event.external_event_id)
  end

  attr_accessor :event
end
