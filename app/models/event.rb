class Event < ApplicationRecord
  validates :name, :date, :external_event_id, presence: true
  validates :external_event_id, uniqueness: true

  has_many :attendees
  has_many :giveaways
  has_many :winners
end
