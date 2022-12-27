require 'rails_helper'

RSpec.describe Winner, type: :model do
  describe "validations" do
    it "should have the same event_id as its giveaway" do
      giveaway = create(:giveaway)
      winner = Winner.create!(giveaway: giveaway, name: "test", email: "test", attendee_id: 1)

      expect(winner.event_id).to eq(giveaway.event_id)
    end
  end
end
