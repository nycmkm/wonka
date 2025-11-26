class Event < ApplicationRecord
  validates :name, :date, :external_event_id, presence: true
  validates :external_event_id, uniqueness: true

  has_many :attendees
  has_many :giveaways
  has_many :winners

  def attendees_without_wins
    attendees
      .where.not(id: winners.select(:attendee_id))
      .order(:name)
  end
end
