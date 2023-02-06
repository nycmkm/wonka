class Winner < ApplicationRecord
  belongs_to :giveaway
  belongs_to :attendee
  # validates_presence_of :name, :email, :attendee_id, :event_id, :giveaway

  after_initialize :set_event_id

  private

  def set_event_id
    self.event_id = giveaway.event_id
  end
end
