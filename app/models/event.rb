class Event < ApplicationRecord
  validates_presence_of :name, :date, :eventbrite_id
  validates_uniqueness_of :eventbrite_id

  has_many :attendees
end
