class Attendee < ApplicationRecord
  belongs_to :event

  validates_presence_of :event_id, :eventbrite_id, :name, :email
end
