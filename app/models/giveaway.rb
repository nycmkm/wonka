class Giveaway < ApplicationRecord
  belongs_to :user
  validates_presence_of :event_id, :name, :user_id
end
