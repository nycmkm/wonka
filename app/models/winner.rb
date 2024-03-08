class Winner < ApplicationRecord
  belongs_to :giveaway
  belongs_to :attendee
  belongs_to :event

  validate :same_event_id_as_giveaway_and_event

  delegate :display_name, :email, to: :attendee, allow_nil: true

  private

  def same_event_id_as_giveaway_and_event
    if giveaway && event_id != giveaway.event_id
      errors.add(:event_id, "must be the same as the giveaway's")
    end

    if attendee && event_id != attendee.event_id
      errors.add(:event_id, "must be the same as the attendee's")
    end
  end
end
