require "rails_helper"

RSpec.describe Giveaway do
  describe "validations" do
    it { is_expected.to belong_to(:event) }

    it { is_expected.to belong_to(:user) }

    it { is_expected.to validate_presence_of(:prize) }

    it { is_expected.to validate_presence_of(:num_winners) }
  end

  describe "#drawn?" do
    it "returns true if winners exist" do
      giveaway = create(:giveaway)

      expect(giveaway).not_to be_drawn

      giveaway.winners.create!(attendee: create(:attendee, event: giveaway.event), event: giveaway.event)

      expect(giveaway).to be_drawn
    end
  end
end
