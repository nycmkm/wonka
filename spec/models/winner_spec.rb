require "rails_helper"

RSpec.describe Winner do
  describe "validations" do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:attendee) }
    it { is_expected.to belong_to(:giveaway) }

    it "is invalid if it has the wrong event id" do
      giveaway = create(:giveaway)
      attendee = create(:attendee)
      event = create(:event)

      winner = Winner.new(giveaway:, attendee:, event:)

      expect(event.id).not_to eq(giveaway.event_id)
      expect(event.id).not_to eq(attendee.event_id)
      expect(winner).not_to be_valid
      expect(winner.errors).to include(:event_id)
    end

    it "is valid if it has the right event id" do
      event = create(:event)
      giveaway = create(:giveaway, event_id: event.id)
      attendee = create(:attendee, event_id: event.id)

      winner = Winner.new(giveaway:, attendee:, event:)

      expect(winner).to be_valid
    end
  end
end
