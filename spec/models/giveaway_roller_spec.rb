require "rails_helper"

RSpec.describe GiveawayRoller do
  describe "#roll" do
    let(:event) { create(:event) }
    let(:num_winners) { 4 }
    let(:giveaway) { create(:giveaway, num_winners:, event:) }

    before do
      20.times { create(:attendee, event:) }
    end

    it "picks the number of winners specified" do
      roller = GiveawayRoller.new(giveaway)

      expect(giveaway.winners.count).to eq(0)
      roller.roll

      expect(giveaway.winners.count).to eq(num_winners)
    end

    it "does not pick a previous winner on the same event" do
      other_giveaway = create(:giveaway, event:)
      attendee = event.attendees.first
      Winner.create!(event:, giveaway: other_giveaway, attendee:)

      giveaway.num_winners = event.attendees.count
      giveaway.save!

      roller = GiveawayRoller.new(giveaway)
      roller.roll

      expect(giveaway.winners.map(&:attendee_id)).not_to include(attendee.id)
    end

    it "destroys and re-rolls the specified winners" do
      roller = GiveawayRoller.new(giveaway)
      roller.roll

      re_rolls = giveaway.winners.limit(2)

      roller = GiveawayRoller.new(giveaway, re_rolls.map(&:id))
      roller.roll

      expect(giveaway.winners.count).to eq(giveaway.num_winners)

      re_rolls.each do |winner|
        expect { Winner.find(winner.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    it "raises an error if you give it an invalid winner id" do
      invalid_id = 200_000

      roller = GiveawayRoller.new(giveaway, [invalid_id])

      expect { roller.roll }.to raise_error(GiveawayRoller::InvalidReRollError)
    end

    it "does not destroy winners who are not re-rolled" do
      roller = GiveawayRoller.new(giveaway)
      roller.roll

      expect { roller.roll }.not_to change(giveaway, :winners)
    end

    it "raises an error if the spots to pick are negative" do
      roller = GiveawayRoller.new(giveaway)
      roller.roll

      giveaway.num_winners -= 10
      giveaway.save!

      expect { roller.roll }.to raise_error(GiveawayRoller::NegativeSpotsError)
    end
  end
end
