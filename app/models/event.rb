class Event < ApplicationRecord
  validates :name, :date, :eventbrite_id, presence: true
  validates :eventbrite_id, uniqueness: true

  has_many :attendees
end
