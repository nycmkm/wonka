class Giveaway < ApplicationRecord
  belongs_to :user
  has_many :winners
  validates_presence_of :event_id, :name, :user
end
