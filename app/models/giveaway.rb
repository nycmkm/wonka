class Giveaway < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :winners

  validates_presence_of :event_id, :prize, :user, :num_winners

  def drawn?
    winners.exists?
  end
end
