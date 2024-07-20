class Giveaway < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :winners, dependent: :destroy
  has_many_attached :images

  validates :prize, :num_winners, presence: true

  scope :drawn, -> { includes(:winners).where.not(winners: { id: nil }) }
  scope :open, -> { includes(:winners).where(winners: { id: nil }) }

  def drawn?
    winners.exists?
  end
end
