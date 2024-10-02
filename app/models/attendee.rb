class Attendee < ApplicationRecord
  belongs_to :event

  validates :external_id, :name, :email, presence: true

  scope :random, -> { order("RANDOM()") }

  def display_name
    discord_name.presence || name
  end
end
