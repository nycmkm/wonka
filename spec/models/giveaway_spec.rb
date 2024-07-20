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

  describe ".drawn" do
    it "returns giveaways with winners" do
      giveaway = create(:giveaway)

      expect(Giveaway.drawn).not_to include(giveaway)

      giveaway.winners.create!(attendee: create(:attendee, event: giveaway.event), event: giveaway.event)

      expect(Giveaway.drawn).to include(giveaway)
    end
  end

  describe ".open" do
    it "returns giveaways without winners" do
      giveaway = create(:giveaway)

      expect(Giveaway.open).to include(giveaway)

      giveaway.winners.create!(attendee: create(:attendee, event: giveaway.event), event: giveaway.event)

      expect(Giveaway.open).not_to include(giveaway)
    end
  end
end
