class Attendee < ApplicationRecord
  belongs_to :event

  validates :eventbrite_id, :name, :email, presence: true
end
