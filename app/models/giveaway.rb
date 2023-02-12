class Giveaway < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :winners, dependent: :destroy

  validates :prize, :num_winners, presence: true

  def drawn?
    winners.exists?
  end
end
