require "rails_helper"

RSpec.describe Attendee do
  describe "validations" do
    it { is_expected.to belong_to(:event) }

    it { is_expected.to validate_presence_of(:external_id) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:email) }
  end

  describe "#display_name" do
    it "uses the discord name if it is present" do
      attendee = Attendee.new(discord_name: "zaphod42", name: "Zaphod Beeblebrox")
      expect(attendee.display_name).to eq("zaphod42")
    end

    it "uses the name if there is no discord name" do
      attendee = Attendee.new(discord_name: nil, name: "Zaphod Beeblebrox")
      expect(attendee.display_name).to eq("Zaphod Beeblebrox")
    end
  end
end
