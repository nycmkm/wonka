require "rails_helper"

RSpec.describe Winner do
  describe "validations" do
    it "has the same event_id as its giveaway" do
      skip("Winner not yet implemented")
      giveaway = create(:giveaway)
      winner = Winner.create!(giveaway:, name: "test", email: "test", attendee_id: 1)

      expect(winner.event_id).to eq(giveaway.event_id)
    end
  end
end
