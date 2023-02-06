require 'rails_helper'

RSpec.describe Giveaway, type: :model do
  describe "validations" do
    let(:valid_attributes) do
      {
        event: create(:event),
        prize: "1000 Keyboards",
        num_winners: 1,
        user: create(:user),
      }
    end

    it "validates presence of event_id" do
      giveaway = Giveaway.new(valid_attributes.except(:event))
      expect(giveaway).to be_invalid
      expect(giveaway.errors).to include(:event_id)
    end

    it "validates presence of prize" do
      giveaway = Giveaway.new(valid_attributes.except(:prize))
      expect(giveaway).to be_invalid
      expect(giveaway.errors).to include(:prize)
    end

    it "validates presence of user" do
      giveaway = Giveaway.new(valid_attributes.except(:user))
      expect(giveaway).to be_invalid
      expect(giveaway.errors).to include(:user)
    end

    it "validates presence of num_winners" do
      giveaway = Giveaway.new(valid_attributes.except(:num_winners))
      expect(giveaway).to be_invalid
      expect(giveaway.errors).to include(:num_winners)
    end
  end

  describe "#drawn?" do
    it "returns true if winners exist" do
      giveaway = create(:giveaway)

      expect(giveaway).not_to be_drawn

      giveaway.winners.create!(attendee: create(:attendee))

      expect(giveaway).to be_drawn
    end
  end
end
